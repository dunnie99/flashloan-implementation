// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.4.22 <0.9.0;

// This import is automatically injected by Remix
import "remix_tests.sol"; 
import "remix_accounts.sol";
import "../Myflashloancontract.sol";

contract testSuite {
    MyFlashloanContract foo;

    /// 'beforeEach' runs before EACH tests
    function beforeEach() public {
            foo=  new MyFlashloanContract();
    }
    
    function testItBorrowedToken() public {
         uint amount = 1 ether;
         address asset = address(0x428D4b75c90eF87d6c586D9423a07c3a7E0a968A);
         Assert.equal(foo.flashloan(), 1, "loan not recieved");
  }

    function getContractBalance() public {
        address _reserve;
        uint256 _amount;
        uint256 _fee;
        bytes memory _params;

         require(_amount <= (address(this), _reserve), "Invalid balance, was the flashLoan successful?");
        Assert.greaterThan(_amount, address(this), "2 should be greater than to 1");

    }

}
