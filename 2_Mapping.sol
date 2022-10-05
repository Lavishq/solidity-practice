// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Mapping {
    mapping(address => uint256) private balances;

    // this function accepts one argument and it saves the amount
    // a user is depositing into a mapping,
    function deposit(uint256 amount) public payable {
        balances[msg.sender] += amount;
        // i tried below code but it reverts everytime
        // (bool sent,) = payable(address(this)).call{value: amount}("");
        // require(sent, "Failed to deposit");
    }

    // this function searches for the user balance inside the balance mapping
    // and returns the balance of whoever is calling the contract.
    function checkBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    receive() external payable {}
}
