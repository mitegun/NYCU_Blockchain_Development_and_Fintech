// Define the API URL for the JSON-RPC provider
const API_URL = 'https://zircuit1.p2pify.com/';

// Retrieve private key from environment variables
const PRIVATE_KEY = "";

// Define address of the proxy contract
const addressProxy = "0x0154f928A3003c9EdddeBC2ccbfFFc9addb7c9b1";

// Define address of the new version of the smart contract
const addressSCV2 = "0x0f7717C22dD73A437053a6fB81539DdDFcA38244";

// Import JSON artifacts for the proxy contract
const contract = require("../artifacts/contracts/SafeProxy.sol/SafeProxy.json");

// Import ethers library for Ethereum interactions
const { ethers, JsonRpcProvider } = require('ethers');

// Create a JSON-RPC provider with the specified API URL
const zircuitProvider = new JsonRpcProvider(API_URL);

// Create a signer using the private key and JSON-RPC provider
const signer = new ethers.Wallet(PRIVATE_KEY, zircuitProvider);

// Instantiate the proxy contract using its address, ABI, and signer
const safeProxy = new ethers.Contract(addressProxy, contract.abi, signer);

// Define the main function for upgrading the contract
async function main() {
    // Call the upgradeTo function of the proxy contract with the new version address
    const upgradeto = await safeProxy.upgradeTo(addressSCV2);
    // Wait for the transaction to be confirmed
    await upgradeto.wait();
    // Log a message indicating the upgrade is done
    console.log("Upgrade done");
}

// Call the main function and handle any errors
main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });
