const flashloan = artifacts.require(“flashloan”);
 contract("flashloan", (accounts) => {
   it("should be able to borrow Ethers", () => {
   

let [addr x, addr y ]= ILendingPoolAddresses;
    it("should be able to create a new loan", async () => {
    

const contractInstance = await flashloancontract.new();
const tokenName = ["loan 1];
contractInstance.flashLoan(tokenName[0]);

 const result = await contractInstance.flashLoan (tokenName[0], {from: lendingPool});
 assert.equal(result.receipt.status, true);
 assert.equal(result.logs[0].args.addr,tokenName[0]);

await contractInstance.flashLoan([0], {from: lendingpool});
await utils.shouldThrow(contractInstance.flashLoan(tokenName[1], {from: lendingpool}));
