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
        return employees[id];
    }

    function payEmployee(uint id) {
        Employee employee = Employee(employees[id]);
        // TODO: verify that the company can payout all the tokens 
        // that the employe accepts.
        // Check the emploee has set their percents

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
    address public employee_address;
    uint public salaryUSD;
    uint[] public token_percents;
    address[] public token_addresses;
    address[] public recieved_token_addresses;

    modifier isEmployee() { if(msg.sender != employee_address) throw; _; }
    modifier isCompany() { if(msg.sender != company_address) throw; _; }

    function () tokenPayable payable {
        // TODO add the token address to recieved tokens
    }

    function Employee(address _employee_address, uint _salaryUSD) {
        company_address = msg.sender;
        employee_address = _employee_address;
        salaryUSD = _salaryUSD;
    }

    function supportsToken(address token_address) returns (bool) {
        for (uint i = 0; i < accepted_token_addresses.length; i++) {
            if (accepted_token_addresses[i] == token_address) {
                return true;
            }
        }
        // TODO: Figure out why returning false doesn't work
        //return false;
        throw;
    }

    // TODO: withdraw(address token, address _to)
    // TODO set ratios once every 6 months

}
