//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

import "hardhat/console.sol";

contract Domains {
  // A "mapping" data type to store their names
  mapping(string => address) public domains;

  // Store values
  mapping(string => string) public records;

  constructor() {
    console.log("This contract registers domains!");
  }

  // A register function that adds their names to our mapping
  function register(string calldata name) public {
    // Check that the name is unregistered
    require(domains[name] == address(0), "Name is already registered.");
    domains[name] = msg.sender;
    console.log("%s has registered a domain!", msg.sender);
  }

  // This will give us the domain owner's address
  function getAddress(string calldata name) public view returns (address) {
    return domains[name];
  }

  function setRecord(string calldata name, string calldata record) public {
    // Check that the owner is the transaction sender
    require(domains[name] == msg.sender, "You don't own this domain");
    records[name] = record;
  }

  function getRecord(string calldata name) public view returns (string memory) {
    return records[name];
  }
}
