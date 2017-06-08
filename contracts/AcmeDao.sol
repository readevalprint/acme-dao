pragma solidity ^0.4.8;


import "./ERC23/implementation/StandardReceiver.sol";
import "./ERC23/interface/ERC23.sol";

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

    function () tokenPayable payable {
        if(tkn.addr != 0) {
            token_addresses.push(tkn.addr);
        }
    }

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

    function payEmployee(uint id) returns (bool) {
        address employee_address = employees[id];
        Employee employee = Employee(employee_address);
        address token_address;
        uint amt;
        uint l = employee.getTokenAddressesLength();
        for (uint i = 0; i < l; i++) {
            token_address = employee.token_addresses(i);
            amt = employee.token_amounts(i);
            ERC23 t = ERC23( token_address);
            t.transfer(employee_address, amt);
        }
        return true;
    }


    function supportsToken(address token_address) returns (bool) {
        return true;
    }
}


contract Employee is StandardReceiver {
    // Employees control their own contract so they can witdraw even if it's terminated
    address public company_address;
    address public employee_address;
    uint public salaryUSD;
    uint[] public token_amounts;
    address[] public token_addresses;
    address[] public recieved_tokens;

    modifier isEmployee() { if(msg.sender != employee_address) throw; _; }
    modifier isCompany() { if(msg.sender != company_address) throw; _; }

    function () tokenPayable payable {
        if(tkn.addr != 0) {
            recieved_tokens.push(tkn.addr);
        }
    }

    function getTokenAddressesLength() constant returns (uint) {
        // Grrr why is everything painful in solidity.
        return token_addresses.length;
    }

    function Employee(address _employee_address, uint _salaryUSD) {
        company_address = msg.sender;
        employee_address = _employee_address;
        salaryUSD = _salaryUSD;
    }

    // TODO: set to isCompany() modifier
    function setAddresseAmount(address _address, uint amt) {
        // This too is super naive, need to do some extream validation on this.
        // But ok to test flow for now.
        token_addresses.push(_address);
        token_amounts.push(amt);
    }
    function supportsToken(address token_address) returns (bool) {
        return true;
    }
    // TODO: withdraw(address token, address _to)
    // TODO set amounts once every 6 months

}
