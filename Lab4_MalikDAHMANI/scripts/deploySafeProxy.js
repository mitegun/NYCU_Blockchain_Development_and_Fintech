const addressSCV1 = "0x47e16D4F694cBE0b72B4a33FAc1721f2F14B2EC6";

async function main() {
    const SafeProxy = await ethers.getContractFactory("SafeProxy");
    const safeProxy = await SafeProxy.deploy(addressSCV1);
    await safeProxy.waitForDeployment();
    console.log("SafeProxy deployed to:", await safeProxy.getAddress());
  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });
  