# flashloan-implementation
Flashloan Implementation - A project under the Web3Ladies Mentorship Cohort 2. 
This project is a smart contract that performs flashloan on Aave.

Flashloans is a way of borrowing assets without collateral as long as liquidity is returned within one block transaction on the blockchain.
In flashloan, transaction of asssets are executed within seconds with smart contract.
To do flashloan, contracts are build to request flashloans.

Smart contract is a self-executing lines of codes written on the blockchain.
Most use cases of flash loans include;
* Arbitrage, Collateral swap, Interest rate swap.
# How do flashloan works on Aave.
* On Aave, the borrower applies for a quick loan.
* To make a profit, the borrower constructs a logic of exchanges, such as sales, trades, and so on.
* The borrower repays the loan, make profit, and pays a fee of 0.09%.
* The transaction is reversed and the funds are returned to the lender if any of the following conditions occur:
    * The borrower did not repay the loan.
    * The transaction does not result in a profit.
# Setting up code
There are six contracts for this project
* MyFlashloanContract.sol
* FlashLoanReceiverBase.sol
* ILendingPoolAddressesProvider.sol
* IFlashLoanReceiver.sol
* ILendingPool.sol
* Withdrawable.sol

