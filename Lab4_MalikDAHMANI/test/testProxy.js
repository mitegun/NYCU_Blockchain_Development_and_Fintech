const {
    expect,
    assert
} = require("chai");
const {
    ethers
} = require("hardhat");

describe("SafeProxy", function () {
    let SafeContract, safeContract, Token, token, owner, addr1;

    before("deploy the contract instance and give addr1 some tokens first", async function () {

        [owner, addr1] = await ethers.getSigners();

        // Deploy SafeContract
        SafeContract = await ethers.getContractFactory("SafeContract");
        safeContract = await SafeContract.deploy();
        await safeContract.waitForDeployment();

        // Deploy Token
        Token = await ethers.getContractFactory("Token");
        token = await Token.deploy();
        await token.waitForDeployment();

        // Deploy SafeContract
        SafeContractV2 = await ethers.getContractFactory("SafeContractV2");
        safeContractV2 = await SafeContractV2.deploy();
        await safeContractV2.waitForDeployment();

        // Deploy Token
        MyFirstProxy = await ethers.getContractFactory("SafeProxy");
        myFirstProxy = await MyFirstProxy.deploy(await safeContract.getAddress());
        await myFirstProxy.waitForDeployment();



    });
    it("Should set the deployer as the owner and implementation to safeContractV1", async function () {
        assert.equal(await myFirstProxy._getOwner(), owner.address);
        assert.equal(await myFirstProxy._getImplementation(), await safeContract.getAddress());
    });
    it("Should revert addr1 not the owner", async function () {
        await expect(myFirstProxy.connect(addr1).upgradeTo(safeContractV2.getAddress())).to.be.revertedWith("You're not the owner")
    });

    it("Should change the current implementation from safeContractV1 to safeContractV2", async function () {
        await myFirstProxy.connect(owner).upgradeTo(await safeContractV2.getAddress());
        assert.equal(await myFirstProxy._getImplementation(), await safeContractV2.getAddress());
    });
});