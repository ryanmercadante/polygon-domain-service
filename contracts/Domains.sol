//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

import "hardhat/console.sol";

contract Domains {
  // A "mapping" data type to store their names
  mapping(string => address) public domains;

  constructor() {
    console.log("This contract registers domains!");
  }

  // A register function that adds their names to our mapping
  function register(string calldata name) public {
    domains[name] = msg.sender;
    console.log("%s has registered a domain!", msg.sender);
  }

  // This will give us the domain owner's address
  function getAddress(string calldata name) public view returns (address) {
    return domains[name];
  }
}
