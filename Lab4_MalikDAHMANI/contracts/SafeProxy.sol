// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SafeProxy { 
    // Storage slot for the owner of the proxy
    bytes32 private constant EIP1967_OWNER_SLOT = keccak256("OwnerV1_"); 
    // Storage slot for the implementation contract
    bytes32 private constant EIP1967_IMPLEMENTATION_SLOT = keccak256("ContractV1");    

    // Event emitted when the implementation contract is upgraded
    event Upgraded(address indexed implementation); 
    // Event emitted when the owner of the proxy is changed
    event NewOwner(address indexed owner); 

    // Constructor to initialize the owner and implementation contract
    constructor(address safeContractV1) {
        _setOwner(msg.sender);
        _setImplementation(safeContractV1);
    }

    // Modifier to restrict access to only the owner
    modifier onlyOwner {
        address theOwnerV1;
        bytes32 theOwnerProxy = EIP1967_OWNER_SLOT;

        assembly {
            theOwnerV1 := sload(theOwnerProxy)
        }
        require(msg.sender == theOwnerV1, "You're not the owner");
        _;
    }

    // Fallback function to delegate calls to the implementation contract
    fallback(bytes calldata callData) external payable returns (bytes memory returnData) {
        address theSafeContractV1 = _getImplementation();
        bool success;

        (success, returnData) = theSafeContractV1.delegatecall(callData);

        if(!success) {
            assembly { revert(add(returnData, 0x20), sload(returnData)) }
        }
    }

    // Fallback function to receive ether
    receive() external payable {}

    // Internal function to set the owner of the proxy
    function _setOwner(address owner) private {
        emit NewOwner(owner);

        bytes32 theOwnerProxy = EIP1967_OWNER_SLOT;
        assembly { sstore(theOwnerProxy, owner)}
    }

    // Internal function to set the implementation contract
    function _setImplementation(address newImplementation) private {
        emit Upgraded(newImplementation);

        bytes32 theSafeContractV1 = EIP1967_IMPLEMENTATION_SLOT;
        assembly { sstore(theSafeContractV1, newImplementation)}
    }

    // Internal function to get the owner of the proxy
    function _getOwner() public view returns(address theOwnerV1) {   
        bytes32 theOwnerProxy = EIP1967_OWNER_SLOT;

        assembly {
            theOwnerV1 := sload(theOwnerProxy)
        }
    }    

    // Internal function to get the implementation contract
    function _getImplementation() public view returns(address theSafeContractV2) {   
        bytes32 theSafeContractV1 = EIP1967_IMPLEMENTATION_SLOT;

        assembly {
            theSafeContractV2 := sload(theSafeContractV1)
        } 
    } 

    // Function to upgrade the implementation contract, only callable by the owner
    function upgradeTo(address newImplementation) public onlyOwner {  
        emit Upgraded(newImplementation);   
        _setImplementation(newImplementation); 
    } 
}
