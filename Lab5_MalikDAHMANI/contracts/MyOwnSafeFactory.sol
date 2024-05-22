// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Importing necessary libraries and contracts from OpenZeppelin
import "@openzeppelin/contracts/utils/Create2.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import "./MyOwnSafeContract.sol";
import "./MyOwnSafeUpgradeableContract.sol";

// Factory contract for deploying instances of MyOwnSafeContract and MyOwnSafeUpgradeableContract
contract MyOwnSafeFactory {

    // Immutable addresses of the implementations for the contracts
    address public immutable myOwnSafeImplementation;
    address public immutable myOwnSafeUpgradeableImplementation;

    // Events to log the deployment of new contracts
    event SafeDeployed(address indexed safeAddress, address indexed owner);
    event SafeUpgradeableDeployed(address indexed proxyAddress, address indexed owner);

    // Constructor initializes the implementations of the contracts
    constructor() {
        myOwnSafeImplementation = address(new MyOwnSafeContract(address(this)));
        myOwnSafeUpgradeableImplementation = address(new MyOwnSafeUpgradeableContract());
    }

    // Function to deploy a new MyOwnSafeContract instance
    function deploySafe(address _owner) external returns (address) {
        MyOwnSafeContract safe = new MyOwnSafeContract(_owner);
        emit SafeDeployed(address(safe), _owner);
        return address(safe);
    }

    // Function to deploy a new MyOwnSafeContract instance using Create2 for deterministic address
    function deploySafeWithCreate2(address _owner, bytes32 salt) external returns (address) {
        address safeAddress = Create2.deploy(
            0,
            salt,
            abi.encodePacked(
                type(MyOwnSafeContract).creationCode,
                abi.encode(_owner)
            )
        );
        emit SafeDeployed(safeAddress, _owner);
        return safeAddress;
    }

    // Function to deploy a new MyOwnSafeUpgradeableContract instance using the Clone library
    function deploySafeUpgradeable(address _owner) external returns (address) {
        address clone = Clones.clone(myOwnSafeUpgradeableImplementation);
        MyOwnSafeUpgradeableContract(clone).initialize(_owner);
        emit SafeUpgradeableDeployed(clone, _owner);
        return clone;
    }

    // Function to deploy a new MyOwnSafeUpgradeableContract instance using Create2 for deterministic address and the Clone library
    function deploySafeUpgradeableWithCreate2(address _owner, bytes32 salt) external returns (address) {
        address clone = Clones.cloneDeterministic(myOwnSafeUpgradeableImplementation, salt);
        MyOwnSafeUpgradeableContract(clone).initialize(_owner);
        emit SafeUpgradeableDeployed(clone, _owner);
        return clone;
    }
}
