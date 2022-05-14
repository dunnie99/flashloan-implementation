//SPDX-License-Identifier:MIT
pragma solidity ^0.6.6;
import "./FlashLoanReceiverBase.sol";
import "./ILendingPoolAddressesProvider.sol";
import "./ILendingPool.sol";
import "../exchange/Exchange.sol";

contract FlashloanV1 is FlashLoanReceiverBaseV1, Exchange {
    address _reserve = address(this);
    /**  
        _addressProvider = address of one of the Lending Pool Providers of Aave

        using DAI LendingPool address 0x506B0B2CF20FAA8f38a4E2B524EE43e1f4458Cc5 

        A list of all deployed contract addresses can be found athttps://docs.aave.com/developers/v/1.0/deployed-contracts/deployed-contract-instances

    */

    constructor(address _addressProvider) FlashLoanReceiverBaseV1(_addressProvider) public{}

    /**
        _asset = address of the asset we want to flash loan
        Flash loan 1000000000000000000 wei (1 ether) worth of `_asset`
     */
    function flashloan(address _asset) public onlyOwner {
        bytes memory data = "";
        uint amount = 1 ether;

        ILendingPoolV1 lendingPool = ILendingPoolV1(addressesProvider.getLendingPool());
        lendingPool.flashLoan(address(this), _asset, amount, data);
    }

    /**
  This function is called after your contract has received the flash loaned amount
     */
    function executeOperation(
        address _reserve,
        uint256 _amount,
        uint256 _fee,
        bytes calldata _params
    )
        external
        override
    {
        require(_amount <= getBalanceInternal(address(this), _reserve), "Invalid balance, was the flashLoan successful?");
       //
        // Your logic goes here.
        // !! Ensure that *this contract* has enough of `_reserve` funds to payback the `_fee` !!
        //

        address token1 = 0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD;
        address token2 = 0x13512979ADE267AB5100878E2e0f485B568328a4;
        // address ownerOfToken1 = 0x2853eB1d81342453c6fA7FF7D03C97a8F142EabA;
        address ownerOfToken1 = address(this);
        address ownerOfToken2 = 0x3ceEE3CF67314501Ec960AC81E7e5A58b99Dbb7a;
        uint amountOfToken1 = 1 ether;
        uint amountOfToken2 = 1 ether;

        swap(
            token1,
            token2,
            ownerOfToken1,
            ownerOfToken2,
            amountOfToken1,
            amountOfToken2
        );

        swap(
            token2,
            token1,
            ownerOfToken2,
            ownerOfToken1,
            amountOfToken2,
            amountOfToken1
        );

        uint totalDebt = _amount.add(_fee);
        transferFundsBackToPoolInternal(_reserve, totalDebt);
    }

}