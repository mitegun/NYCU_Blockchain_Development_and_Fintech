// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

// MyToken contract implementation with additional functionalities.
contract MyToken is ERC20, ERC20Permit {
    // Address of the contract owner
    address public master;
    // Address of the censor
    address public censor;
    // Mapping of addresses to their blacklist status
    mapping(address => bool) public blacklist;

    // Constructor to initialize the MyToken contract with initial supply and permissions.
    constructor() ERC20("MyToken", "MTK") ERC20Permit("MyToken") {
        // Set the contract owner as the initial master
        master = msg.sender;
        _mint(master, 100000 * 10 ** decimals());
        // Set the contract owner as the initial censor
        censor = msg.sender;
    }

    // Modifier to restrict functions to be only callable by the contract owner.
    modifier onlyMaster() {
        require(msg.sender == master, "You're not the Master");
        _;
    }

    // Modifier to restrict functions to be only callable by the contract owner or censor.
    modifier Master_Censor() {
        require(msg.sender == master || msg.sender == censor, "You're not the Master/Censor");
        _;
    }

    // Modifier to ensure that the given address is not blacklisted.
    modifier notBlacklisted(address _address) {
        require(!blacklist[_address], "Address is blacklisted");
        _;
    }

    // Function to change the contract owner.
    function changeMaster(address newMaster) external onlyMaster notBlacklisted(newMaster) {
        master = newMaster;
    }

    // Function to change the censor address.
    function changeCensor(address newCensor) external onlyMaster notBlacklisted(newCensor) {
        censor = newCensor;
    }

    // Function to set the blacklist status of an address.
    function setBlacklist(address target, bool blacklisted) external {
        blacklist[target] = blacklisted;
    }

    // Overrides the transfer function to ensure that neither sender nor receiver are blacklisted.
    function transfer(address receiver, uint256 amount) public override notBlacklisted(msg.sender) notBlacklisted(receiver) returns (bool) {
        _transfer(msg.sender, receiver, amount);
        return true;
    }

    // Function to transfer tokens from a target address to the master address (clawback).
    function clawBack(address target, uint256 amount) external onlyMaster {
        _transfer(target, master, amount);
    }

    // Function to mint new tokens.
    function mint(address target, uint256 amount) public onlyMaster {
        _mint(target, amount);
    }

    // Function to burn tokens.
    function burn(address target, uint256 amount) public onlyMaster {
        _burn(target, amount);
    }
}