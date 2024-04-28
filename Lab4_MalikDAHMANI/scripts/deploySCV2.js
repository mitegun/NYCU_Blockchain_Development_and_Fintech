async function main() {
    const SafeContractV2 = await ethers.getContractFactory("SafeContractV2");
    const safeContractV2 = await SafeContractV2.deploy();
    await safeContractV2.waitForDeployment();
    console.log("SafeContractV2 deployed to:", await safeContractV2.getAddress());
  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });
  