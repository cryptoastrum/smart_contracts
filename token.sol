// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

contract CompanyDAO {
    address public owner;
    uint256 workerId = 1;

    struct Worker {
        uint id;
        string name;
        address boss;
        string location;
        uint pay;
        uint payCheck;
        string office;
        string role;
    }

    Worker[] public allWorkers;
    mapping (address => uint) funds;

    constructor() public {
        owner = msg.sender;
        funds[address(this)] = 15000;
    }
    
    function addFunds(uint256 _amount) public payable {
        funds[address(this)] += _amount;
    }

    function payAllWorkers() public payable {
        require(msg.sender == owner, "Only the owner can pay");

        for (uint i = 0; i < allWorkers.length; i++) {
            funds[address(this)] -= allWorkers[i].pay;
            allWorkers[i].payCheck += allWorkers[i].pay;
        }       
    }

    function addWorker(string calldata _workerName, uint _pay, string calldata _location, string calldata _role, string calldata _office) public {
        require(msg.sender == owner, "Only the owner can add workers!");
        allWorkers.push(Worker(workerId, _workerName, msg.sender,_location, _pay, 0 , _role, _office));
        workerId ++;
    }
}

