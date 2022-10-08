// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Payable {
    mapping(address => uint256) private balances;

    // deposit() accepts ETH through the payable modifier and updates user balance accordingly
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function checkBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    receive() external payable {}
}
