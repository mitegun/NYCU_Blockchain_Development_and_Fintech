const {
  expect,
  assert
} = require("chai");
const {
  ethers
} = require("hardhat");

describe("SafeContract", function () {
  let SafeContract, safeContract, Token, token, owner, addr1;

  before("deploy the contract instance and give user some tokens first", async function () {

    [owner, addr1] = await ethers.getSigners();

    // Deploy SafeContract
    SafeContract = await ethers.getContractFactory("SafeContract");
    safeContract = await SafeContract.deploy();
    await safeContract.waitForDeployment();
    
    // Deploy Token
    Token = await ethers.getContractFactory("Token");
    token = await Token.deploy();
    await token.waitForDeployment();

    // Transfer tokens to addr1
    await token.connect(owner).transfer(addr1.address, 10000);


  });

  it("Should set the right owner", async function () {
    assert.equal(await safeContract.owner(), owner.address);
  });

  it("Should deposit, withdraw tokens and take fee", async function () {
    const amount = 10000;
    // Deposit tokens
    const overrides = {
      gasLimit: 3000000, // Set a higher gas limit
    };
    await token.connect(addr1).approve(safeContract.getAddress(), amount, overrides);

    // Deposit tokens into SafeContract
    const depositTx = await safeContract.connect(addr1).deposit(token.getAddress(), amount, overrides);
    await depositTx.wait();

    // Check balance of SafeContract after deposit
    const balanceAfterDeposit = await token.balanceOf(safeContract.getAddress());
    expect(balanceAfterDeposit.toString()).to.equal(amount.toString());

    // Check balance of addr1 after deposit
    const addr1BalanceAfterDeposit = await token.balanceOf(addr1.getAddress());
    expect(addr1BalanceAfterDeposit.toString()).to.equal("0");

    // Withdraw tokens from SafeContract
    const withdrawTx = await safeContract.connect(addr1).withdraw(token.getAddress(), amount);
    await withdrawTx.wait()

    // Withdraw tokens from SafeContract
    const balanceAfterWithdrawal = await token.balanceOf(safeContract.getAddress());
    expect(balanceAfterWithdrawal.toString()).to.eql("10");

    // Check balance of addr1 after withdrawal
    const addr1BalanceAfterWithdrawal = await token.balanceOf(addr1.getAddress());
    expect(addr1BalanceAfterWithdrawal.toString()).to.equal((9990).toString());

    // Take fee from SafeContract
    const feeTx = await safeContract.connect(owner).takeFee(token.getAddress());
    await feeTx.wait()

    // Check balance of SafeContract after taking fee
    const balanceAfterFee = await token.balanceOf(safeContract.getAddress());
    expect(balanceAfterFee.toString()).to.eql("0");

    // Check balance of owner after taking fee
    const ownerBalanceAfterFee = await token.balanceOf(owner.getAddress());
    expect(ownerBalanceAfterFee.toString()).to.equal("9999999999999999999990010");

  });

  it("should revert takeFee call from user", async function () {
    await expect(safeContract.connect(addr1).takeFee(await token.getAddress())).to.be.rejectedWith("You're not the Owner");
  });

  it("should revert takeFee call because no fee", async function () {
    await expect(safeContract.connect(owner).takeFee(await token.getAddress())).to.be.rejectedWith("No fees available for this token");
  });

  it("should revert withdraw call because no token left", async function () {
    await expect(safeContract.connect(addr1).withdraw(await token.getAddress(), 100)).to.be.rejectedWith("Insufficient balance");
  });
});