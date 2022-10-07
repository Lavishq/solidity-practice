// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

error Modifier__NotTheOwner();
error Modifier__haveNeverDeposited();
error Modifier__AmountToSmall();

// 1
// Add a withdraw function and create a modifier that only allows
// the owner of the contract to withdraw the funds.

// 2
// Add an addFund function and create a modifier that only allows users that
// have deposited using the deposit function, to increase their balance on the mapping.
// The function should accept the amount to be added and update the mapping to have the new balance

contract Modifier {
    // 1
    address public s_owner;
    mapping(address => uint256) private balances;

    modifier onlyOwner() {
        if (s_owner == msg.sender) {
            _;
        } else revert Modifier__NotTheOwner();
    }

    constructor() {
        s_owner = msg.sender;
    }

    function withdraw(uint256 _amount) public payable onlyOwner {
        balances[msg.sender] -= _amount;
        (bool sent, ) = payable(msg.sender).call{value: address(this).balance}(
            ""
        );
        require(sent, "Failed to withdraw");
    }

    // 3.1 Create a private constant variable called Fee
    uint256 private constant Fee = 0.01 ether;

    // 2 aren't deposit() and addFund() same? but one having modifiers and restrictions.
    // 3.3 Add it to the addFund function => value(_amount)
    function addFund(uint256 _amount)
        public
        payable
        haveDeposited
        value(_amount)
    {
        balances[msg.sender] += _amount;
    }

    modifier haveDeposited() {
        // 3.2 In the modifier check if the value(_amount) it accepts is less than the Fee,
        // revert with a custom error AmountToSmall()
        if (balances[msg.sender] != 0) {
            _;
        } else revert Modifier__haveNeverDeposited();
    }

    function deposit(uint256 amount) public payable {
        balances[msg.sender] += amount;
    }

    // 3 Create a modifier that accepts a value(uint256 _amount)
    modifier value(uint256 _amount) {
        // 3.2
        if (_amount < Fee) {
            revert Modifier__AmountToSmall();
        }
        _;
    }

    function checkBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    receive() external payable {}
}
