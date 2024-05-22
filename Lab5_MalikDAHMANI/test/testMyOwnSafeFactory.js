const { expect, assert } = require("chai");
const { ethers } = require("hardhat");

const salt = "0x60298f78cc0b47170ba79c10aa3851d7648bd96f2f8e46a19dbc777c36fb0c00";

describe("SafeFactory", function () {
  let SafeFactory, safeFactory, owner, user;

  before("deploy the factory contract", async function () {
    // Get an owner and a user address
    [owner, user] = await ethers.getSigners();

    // Deploy the factory contract
    SafeFactory = await ethers.getContractFactory("MyOwnSafeFactory");
    safeFactory = await SafeFactory.deploy();
    await safeFactory.waitForDeployment();
    console.log("SafeFactory deployed");
  });

  it("should deploy the non-upgradeable version with create1", async function () {
    console.log("calling deploySafe function");
    const tx = await safeFactory.connect(owner).deploySafe(owner.address);
    const receipt = await tx.wait();

    // Log the entire receipt for debugging
    console.log("Transaction receipt:", receipt);

    // Manually parse logs for SafeDeployed event
    let safeAddress;
    for (const log of receipt.logs) {
      try {
        const parsedLog = safeFactory.interface.parseLog(log);
        if (parsedLog.name === 'SafeDeployed') {
          safeAddress = parsedLog.args.safeAddress;
          break;
        }
      } catch (e) {
        // Skip logs that cannot be parsed
        continue;
      }
    }
    console.log("SafeDeployed event: safeAddress =", safeAddress);
  });

  it("should deploy the non-upgradeable version with create2", async function () {
    console.log("calling deploySafeWithCreate2 function");
    const tx = await safeFactory.connect(owner).deploySafeWithCreate2(owner.address, salt);
    const receipt = await tx.wait();

    // Log the entire receipt for debugging
    console.log("Transaction receipt:", receipt);

    // Manually parse logs for SafeDeployed event
    let safeAddress;
    for (const log of receipt.logs) {
      try {
        const parsedLog = safeFactory.interface.parseLog(log);
        if (parsedLog.name === 'SafeDeployed') {
          safeAddress = parsedLog.args.safeAddress;
          break;
        }
      } catch (e) {
        // Skip logs that cannot be parsed
        continue;
      }
    }
    console.log("SafeDeployed event: safeAddress =", safeAddress);
  });

  it("should deploy the upgradeable version with create1", async function () {
    console.log("calling deploySafeUpgradeable function");
    const tx = await safeFactory.connect(owner).deploySafeUpgradeable(owner.address);
    const receipt = await tx.wait();

    // Log the entire receipt for debugging
    console.log("Transaction receipt:", receipt);

    // Manually parse logs for SafeUpgradeableDeployed event
    let proxyAddress;
    for (const log of receipt.logs) {
      try {
        const parsedLog = safeFactory.interface.parseLog(log);
        if (parsedLog.name === 'SafeUpgradeableDeployed') {
          proxyAddress = parsedLog.args.proxyAddress;
          break;
        }
      } catch (e) {
        // Skip logs that cannot be parsed
        continue;
      }
    }
    console.log("SafeUpgradeableDeployed event: proxyAddress =", proxyAddress);
  });

  it("should deploy the upgradeable version with create2", async function () {
    console.log("calling deploySafeUpgradeableWithCreate2 function");
    const tx = await safeFactory.connect(owner).deploySafeUpgradeableWithCreate2(owner.address, salt);
    const receipt = await tx.wait();

    // Log the entire receipt for debugging
    console.log("Transaction receipt:", receipt);

    // Manually parse logs for SafeUpgradeableDeployed event
    let proxyAddress;
    for (const log of receipt.logs) {
      try {
        const parsedLog = safeFactory.interface.parseLog(log);
        if (parsedLog.name === 'SafeUpgradeableDeployed') {
          proxyAddress = parsedLog.args.proxyAddress;
          break;
        }
      } catch (e) {
        // Skip logs that cannot be parsed
        continue;
      }
    }
    console.log("SafeUpgradeableDeployed event: proxyAddress =", proxyAddress);
  });
});
