//SPDX-License-Identifier:MIT
pragma solidity ^0.6.6;
import "./FlashLoanReceiverBase.sol";
import "./ILendingPoolAddressesProvider.sol";
import "./ILendingPool.sol";
import "./exchange/Exchange.sol";

contract FlashloanV1 is FlashLoanReceiverBaseV1, Exchange {
    
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
  This function is called after contract has received the flash loaned amount
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
        // logic goes here.
        // !! Ensure that *this contract* has enough of `_reserve` funds to payback the `_fee` !!
        //

        address token1 = 0xA9C8CFDab3744CF384D1932536A84a25cd84D731; // asset address to swap eg aave DAI contract address
        address token2 = 0xD17886D93D76714B1e5b73728FAEB158918FbaFd; // asset address to swap eg aave USDT contract address
        address ownerOfToken1 = 0xB0274A52D7cF71Ac50D8cDC1c1479D777E29C564; // owner of Token1
        address ownerOfToken2 = 0x22329EbC0D33A237B665c5e1B5c00bf58F311006; // owner of Token2
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