// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SafeContract {
    address public owner;
    mapping(address => uint256) public balances;
    mapping(address => uint256) public fees;

    // Constructor to set the owner of the contract
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict access to only the owner
    modifier onlyMaster() {
        require(msg.sender == owner, "You're not the Owner");
        _;
    }
    
    // Function to get the owner of the contract
    function getOwner() public view returns(address theOwnerV1) {   
        theOwnerV1 = owner;
    }  

    // Function to deposit tokens into the contract
    function deposit(address token, uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(token != address(0), "Invalid token address");

        // Transfer tokens from the caller to this contract
        require(IERC20(token).transferFrom(msg.sender, address(this), amount), "Transfer failed");

        // Update balances
        balances[token] += amount;
    }

    // Function to withdraw tokens from the contract
    function withdraw(address token, uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(amount <= balances[token], "Insufficient balance");

        uint256 fee = amount / 1000; // 0.1% fee
        uint256 amountAfterFee = amount - fee;

        // Transfer tokens to the caller
        require(IERC20(token).transfer(msg.sender, amountAfterFee), "Transfer failed");

        // Update balances and fees
        balances[token] -= amount;
        fees[token] += fee;
    }

    // Function for the owner to withdraw accumulated fees
    function takeFee(address token) external onlyMaster {
        require(fees[token] > 0, "No fees available for this token");

        uint256 feeAmount = fees[token];
        fees[token] = 0;

        // Transfer fee to owner
        require(IERC20(token).transfer(owner, feeAmount), "Transfer failed");
    }
}
