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

    function () tokenPayable payable {}

    modifier isAdmin() { if(msg.sender != owner) throw; _; }

    function newEmployee(address authorized_address, uint salaryUSD) returns (address, uint) {
        address contract_address = new Employee(authorized_address, salaryUSD);
        employees.push(contract_address);
        uint id = employees.length;
        NewEmployee(id, contract_address);
        return (contract_address, id);
    }
    //TODO removeEmployee()

    function getEmployee(uint id) returns (address) {
        return ;
    }

    function payEmployee(uint id) {
        Employee employee = Employee(employees[id]);
        
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


contract Employee is StandardReceiver {
    address public company_address;
    address public authorized_address;
    uint public salaryUSD;
    address[] public accepted_token_addresses;
    uint[] public ratios;

    function () tokenPayable payable {}

    function Employee(address authorized_address, uint _salaryUSD) {
        company_address = msg.sender;
        authorized_address = authorized_address;
        salaryUSD = _salaryUSD;
    }

    modifier isEmployee() { if(msg.sender != authorized_address) throw; _; }
    modifier isCompany() { if(msg.sender != company_address) throw; _; }
    // TODO set ratios once every 6 months

}
