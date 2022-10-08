// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Fallback {
    // To ensure that our smart contract can receive ETH sent to it via transfers, we will
    // create a fallback or receive payable function. The task is to create the fallback()
    // and make sure when a user transfers ETH to the smart contract,
    // the transaction does not get reverted
    fallback() external payable {}

    receive() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
