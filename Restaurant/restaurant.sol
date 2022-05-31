// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Restaurant{
    address public owner;

    uint256 receiptId = 0;
    uint256 tableId = 0;

    struct Table {
        uint256 tableId;
        string order;
        string serverName;
        Receipt receipt;
        bool isPaid;
    }

    struct Receipt {
        uint receiptId;
        string server;
        uint256 price;
    }

    Table[] allTables;

    constructor() {
        owner = msg.sender;
    }


    mapping(uint256 => Table) tableMatch;

    // the web3 connected application should have shared logic with the SC
    function serveTable(string calldata _serverName, string calldata _order) public {
            allTables.push(Table(tableId, _order, _serverName, Receipt(receiptId, _serverName,0), false));
            tableMatch[tableId] = Table(tableId, _order, _serverName, Receipt(receiptId, _serverName,0), false);
            receiptId++;
            tableId++;
    }

    function getAllTables() public view returns(Table[] memory) {
        return allTables;
    }

    function getTable(uint256 _id) public view returns (Table memory) {
        return tableMatch[_id];
    }

    function payCheck(uint256 _price, uint256 _tableId) public payable {
        Table storage table = tableMatch[_tableId];
        table.isPaid = true;
        table.receipt = Receipt(table.receipt.receiptId, table.serverName, _price);
        tableMatch[_tableId] = table;
    }
}