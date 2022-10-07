// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Inheritance is ERC20 {
    constructor(uint256 initialSupply) ERC20("Inheritance20", "IN20") {
        _mint(msg.sender, initialSupply);
    }
}
