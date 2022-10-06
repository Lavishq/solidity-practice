// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

error Modifier__NotTheOwner();
error Modifier__haveNeverDeposited();
error Modifier__AmountToSmall();

contract Events {
    address public s_owner;
    mapping(address => uint256) private balances;
    uint256 private constant Fee = 0.01 ether;

    event FundsDeposited(address user, uint256 amount);
    event ProfileUpdated(address user);

    constructor() {
        s_owner = msg.sender;
    }

    modifier onlyOwner() {
        if (s_owner == msg.sender) {
            _;
        } else revert Modifier__NotTheOwner();
    }

    modifier value(uint256 _amount) {
        if (_amount < Fee) {
            revert Modifier__AmountToSmall();
        }
        _;
    }

    modifier haveDeposited() {
        if (balances[msg.sender] != 0) {
            _;
        } else revert Modifier__haveNeverDeposited();
    }

    function withdraw() public payable onlyOwner {
        (bool sent, ) = payable(msg.sender).call{value: address(this).balance}(
            ""
        );
        require(sent, "Failed to withdraw");
        emit ProfileUpdated(msg.sender);
    }

    function addFund(uint256 _amount)
        public
        payable
        haveDeposited
        value(_amount)
    {
        balances[msg.sender] += _amount;
        emit ProfileUpdated(msg.sender);
    }

    function deposit(uint256 amount) public payable {
        balances[msg.sender] += amount;
        emit FundsDeposited(msg.sender, amount);
    }

    function checkBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    receive() external payable {}
}
