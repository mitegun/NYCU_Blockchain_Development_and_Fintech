// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MyContract {
    address public token0;
    address public token1;
    uint256 public conversionRate;
    address[] userList;
    mapping(address => uint256) public userToken0Balance; // Track balances of token0 for each user
    mapping(address => uint256) public userToken1Balance; // Track balances of token1 for each user
    mapping(address => uint256) public userLiquidityPercentage; // Track the liquidity percentage of each user

    constructor(address _token0, address _token1, uint256 _conversionRate) {
        token0 = _token0;
        token1 = _token1;
        conversionRate = _conversionRate;
    }

    // Function to add a user to the userList
    function addUserToList(address user) internal {
        userList.push(user);
    }

    // Function to check if a user is in the userList
    function isUserInList(address user) internal view returns (bool) {
        for (uint256 i = 0; i < userList.length; i++) {
            if (userList[i] == user) {
                return true;
            }
        }
        return false;
    }

    // Function for trading tokens. It takes the token to trade from and the amount to trade as input.
    function trade(address tokenFrom, uint256 fromAmount) external {
        // Check if the token being traded is valid (either token0 or token1).
        require(tokenFrom == token0 || tokenFrom == token1, "Invalid token");

        // Variable to store the amount of tokens to receive.
        uint256 toAmount;

        // Calculate the amount of tokens to receive based on the conversion rate.
        if (tokenFrom == token0) {
            toAmount = (fromAmount * 10000) / conversionRate;
        } else {
            toAmount = (fromAmount * conversionRate) / 10000;
        }

        // Check if the sender has enough balance to perform the trade.
        require(IERC20(tokenFrom).balanceOf(msg.sender) >= fromAmount, "Insufficient balance");

        // Transfer tokens from the sender to this contract.
        IERC20(tokenFrom).transferFrom(msg.sender, address(this), fromAmount);

        // Update contract liquidity by subtracting the traded amounts from the total balances.
        uint256 totalToken0 = IERC20(token0).balanceOf(address(this));
        uint256 totalToken1 = IERC20(token1).balanceOf(address(this));
        uint256 contractToken0Balance = totalToken0 - fromAmount;
        uint256 contractToken1Balance = totalToken1 - toAmount;

        // Update contract liquidity.
        userToken0Balance[address(this)] = contractToken0Balance;
        userToken1Balance[address(this)] = contractToken1Balance;

        // Transfer tokens to the sender based on the traded amounts.
        if (tokenFrom == token0) {
            IERC20(token1).transfer(msg.sender, toAmount);
        } else {
            IERC20(token0).transfer(msg.sender, toAmount);
        }
    }

    function provideLiquidity(uint256 token0Amount, uint256 token1Amount) external {

        // Retrieve the total balances of token0 and token1 in the contract.
        uint256 totalToken0 = IERC20(token0).balanceOf(address(this));
        uint256 totalToken1 = IERC20(token1).balanceOf(address(this));

        // Calculate the ratio of token0 and token1 in the current liquidity pool.
        uint256 token0Ratio = totalToken0 > 0 ? (totalToken0 * 10000) / (totalToken0 + token0Amount) : 0;
        uint256 token1Ratio = totalToken1 > 0 ? (totalToken1 * 10000) / (totalToken1 + token1Amount) : 0;

        // Adjust the token amounts to maintain the ratio.
        if (token0Ratio > token1Ratio) {
            token1Amount = (token0Amount * totalToken1) / totalToken0;
        } else if (token0Ratio < token1Ratio) {
            token0Amount = (token1Amount * totalToken0) / totalToken1;
        }

        // Update user balances with the provided token amounts.
        userToken0Balance[msg.sender] += token0Amount;
        userToken1Balance[msg.sender] += token1Amount;

        // Transfer tokens from the sender to the contract.
        IERC20(token0).transferFrom(msg.sender, address(this), token0Amount);
        IERC20(token1).transferFrom(msg.sender, address(this), token1Amount);

        // Add the sender to the user list if not already included.
        if (!isUserInList(msg.sender)) {
            addUserToList(msg.sender);
        }

        // Update the total liquidity in the contract.
        uint256 totalToken0Contract = IERC20(token0).balanceOf(address(this));
        uint256 totalToken1Contract = IERC20(token1).balanceOf(address(this));
        uint256 totalLiquidity = totalToken0Contract * conversionRate / 10000 + totalToken1Contract;

        // Calculate and update the liquidity percentage for all users.
        for (uint256 i = 0; i < userList.length; i++) {
            address user = userList[i];
            uint256 newLiquidityPercentage = 0;
            if (totalLiquidity > 0) {
                newLiquidityPercentage = (userToken0Balance[user] * conversionRate / 10000 + userToken1Balance[user]) / totalLiquidity;
            }
            userLiquidityPercentage[user] = newLiquidityPercentage;
        }
    }

    function withdrawLiquidity() external {
        // Retrieve the user's balances of token0 and token1.
        uint256 userToken0Amount = userToken0Balance[msg.sender];
        uint256 userToken1Amount = userToken1Balance[msg.sender];

        // Retrieve the total balances of token0 and token1 in the contract.
        uint256 token0Contract = IERC20(token0).balanceOf(address(this));
        uint256 token1Contract = IERC20(token1).balanceOf(address(this));

        // Ensure that the user has liquidity available to withdraw.
        require(userToken0Amount > 0 || userToken1Amount > 0, "No liquidity available");

        // Calculate the amount of tokens to withdraw based on the percentage of liquidity provided by the user.
        uint256 token0ToWithdraw = token0Contract * userLiquidityPercentage[msg.sender];
        uint256 token1ToWithdraw = token1Contract * userLiquidityPercentage[msg.sender];

        // Transfer tokens to the user and update contract balances accordingly.
        if (token0ToWithdraw > 0) {
            IERC20(token0).transfer(msg.sender, token0ToWithdraw);
            token0Contract -= token0ToWithdraw;
        }
        if (token1ToWithdraw > 0) {
            IERC20(token1).transfer(msg.sender, token1ToWithdraw);
            token1Contract -= token1ToWithdraw;
        }

        // Reset the user's balances and liquidity percentage to zero.
        userToken0Balance[msg.sender] = 0;
        userToken1Balance[msg.sender] = 0;
        userLiquidityPercentage[msg.sender] = 0;
    }
}
