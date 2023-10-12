// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Votacion {
    struct Proposal {
        string name;
        uint voteCount;
    }

    address public owner;
    mapping(address => bool) public whitelist;
    mapping(address => bool) public hasVoted;

    Proposal[] public proposals;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    modifier onlyWhitelisted() {
        require(whitelist[msg.sender] == true, "You are not whitelisted");
        _;
    }

    modifier hasNotVoted() {
        require(!hasVoted[msg.sender], "You have already voted");
        _;
    }

    function addProposal(string memory _name) public onlyOwner {
        Proposal memory newProposal = Proposal({
            name: _name,
            voteCount: 0
        });
        proposals.push(newProposal);
    }

    function addToWhitelist(address _address) public onlyOwner {
        whitelist[_address] = true;
    }

    function vote(uint _proposalIndex) public onlyWhitelisted hasNotVoted {
        proposals[_proposalIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
    }
}
