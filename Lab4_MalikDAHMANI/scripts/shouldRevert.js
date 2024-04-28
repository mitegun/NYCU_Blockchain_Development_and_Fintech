// Define the URL for the JSON-RPC provider
const API_URL = 'https://zircuit1.p2pify.com/';

// Define the private key for signing transactions
const PRIVATE_KEY = "";

// Define address of the proxy contract
const addressProxy = "0x0154f928A3003c9EdddeBC2ccbfFFc9addb7c9b1";

// Import ethers library for Ethereum interactions
const { ethers, JsonRpcProvider } = require('ethers');

// Create a JSON-RPC provider with the specified API URL
const zircuitProvider = new JsonRpcProvider(API_URL);

// Create a signer using the private key and JSON-RPC provider
const signer = new ethers.Wallet(PRIVATE_KEY, zircuitProvider);

// Define the main function for executing the transaction
async function main() {
    // Import JSON artifacts for the SafeContract
    const safeContract = require("../artifacts/contracts/SafeContract.sol/SafeContract.json");
    // Instantiate the SafeProxy contract using its address, ABI, and signer
    const safeProxy = new ethers.Contract(addressProxy, safeContract.abi, signer);
    
    // Execute the transaction to take a fee on a token
    const tx = await safeProxy.takeFee("0xB56e7D479ab6fF0c750356F74b1D632F21E389eD",{gasLimit: 1000000 });
    
    // Wait for the transaction to be confirmed
    await tx.wait();
}

// Call the main function and handle any errors
main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });
