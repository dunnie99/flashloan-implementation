//SPDX-License-Identifier:MIT
pragma solidity 0.6.6;
import "./FlashLoanReceiverBase.sol";
import "./ILendingPoolAddressesProvider.sol";
import "./ILendingPool.sol";

contract FlashloanV1 is FlashLoanReceiverBaseV1 {

    constructor(
    address _addressProvider,
    address _dai)
X   FlashLoanReceiverBaseV1(_addressProvider) 
    public{
    provider = LendingPoolAddressProvider(_provider);
    dai =_dai;

    }

 /**
        Flash loan 1000000000000000000 wei (1 ether) worth of `_asset`
     */
 function flashloan(uint amount, bytes calldata ) public onlyOwner {
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


        uint totalDebt = _amount.add(_fee);
        transferFundsBackToPoolInternal(_reserve, totalDebt);
    }

}

