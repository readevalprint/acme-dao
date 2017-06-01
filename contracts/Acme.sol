pragma solidity ^0.4.8;


import "./ERC23/implementation/StandardReceiver.sol";

contract Company is StandardReceiver {

    event NewEmployee(uint id, address contract_address);
    address[] employees;
    address owner;

    // tokens the company will pay salaries with
    address[] public token_addresses;

    function Company()  {
        // TODO: make a way to transfer ownership of company
        owner = msg.sender;
    }

    function () tokenPayable  {}

    modifier isAdmin() { if(msg.sender != owner) throw; _; }


    function newEmployee(address withdraw_address, uint salaryUSD) returns (address, uint) {
        address contract_address = new Employee(withdraw_address, salaryUSD);
        employees.push(contract_address);
        uint id = employees.length;
        NewEmployee(id, contract_address);
        return (contract_address, id);
    }

    function getEmployee(uint id) returns (address) {
        return employees[id];
    }

    function startAcceptingToken(address token_address) {
        token_addresses.push(token_address);
    }
    function stopAcceptingToken(address token_address) {
        for (uint i = 0; i < token_addresses.length; i++) {
            if (token_addresses[i] == token_address) {
                delete token_addresses[i];
            }
        }
    }

    function supportsToken(address token_address) returns (bool) {
        for (uint i = 0; i < token_addresses.length; i++) {
            if (token_addresses[i] == token_address) {
                return true;
            }
        }
    // TODO: Figure out why returning false doesn't work
    //return false;
    throw;
    }
}


contract Employee {
    address public company_address;
    address public withdraw_address;
    uint public salaryUSD;

    function Employee(address _withdraw_address, uint _salaryUSD) {
        company_address = msg.sender;
        withdraw_address = _withdraw_address;
        salaryUSD = _salaryUSD;
    }

}
