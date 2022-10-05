// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Mapping {
    struct User {
        string name;
        uint8 age;
    }

    User[] public user;

    // this function accepts 2 arguments that represent the details of the user
    // calling the smart contract and it saves them into a defined struct,
    function setUserDetails(string calldata name, uint8 age) public {
        user.push(User(name, age));
    }

    // this function retrieves and returns the details saved for the user calling the contract.
    function getUserDetail(uint256 index)
        public
        view
        returns (string memory, uint8)
    {
        User memory current_user = user[index];
        return (current_user.name, current_user.age);
    }
}
