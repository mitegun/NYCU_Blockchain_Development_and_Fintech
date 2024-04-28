async function main() {
    const SafeContract = await ethers.getContractFactory("SafeContract");
    const safeContract = await SafeContract.deploy();
    await safeContract.waitForDeployment();
    console.log("SafeContract deployed to:", await safeContract.getAddress());
  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });
  