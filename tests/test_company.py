import pytest
from ethereum.tester import TransactionFailed


@pytest.fixture()
def company_contract(chain):
    CompanyFactory = chain.get_contract_factory('Company')
    deploy_txn_hash = CompanyFactory.deploy()
    contract_address = chain.wait.for_contract_address(deploy_txn_hash)
    return CompanyFactory(address=contract_address)


@pytest.fixture()
def token_contracts(chain):
    FooFactory = chain.get_contract_factory('FooToken')
    deploy_txn_hash = FooFactory.deploy(args=[100])
    foo_contract_address = chain.wait.for_contract_address(deploy_txn_hash)
    BarFactory = chain.get_contract_factory('BarToken')
    deploy_txn_hash = BarFactory.deploy(args=[100])
    bar_contract_address = chain.wait.for_contract_address(deploy_txn_hash)
    return FooFactory(address=foo_contract_address), BarFactory(address=bar_contract_address)


def test_employee(company_contract, accounts, chain, token_contracts):
    foo, bar = token_contracts
    assert company_contract
    employee_address = accounts[1]
    SALARY_USD = 100000
    tx = company_contract.transact().newEmployee(employee_address, SALARY_USD)
    chain.wait.for_receipt(tx)

    employee_contract_address = company_contract.call().getEmployee(0)
    EmployeeFactory = chain.provider.get_base_contract_factory('Employee')
    employee_contract = EmployeeFactory(address=employee_contract_address)

    # Assert all the things
    assert employee_contract.call().company_address() == company_contract.address
    assert employee_contract.call().employee_address() == employee_address
    assert employee_contract.call().salaryUSD() == SALARY_USD


def test_accept_token(company_contract, token_contracts, accounts, chain, web3):
    foo, bar = token_contracts
    assert company_contract

    assert foo.call().balanceOf(company_contract.address) == 0
    chain.wait.for_receipt( foo.transact().transfer(company_contract.address, 1))
    assert foo.call().balanceOf(company_contract.address) == 1

    employee_address = accounts[1]
    SALARY_USD = 100000
    tx = company_contract.transact().newEmployee(employee_address, SALARY_USD)
    chain.wait.for_receipt(tx)

    employee_contract_address = company_contract.call().getEmployee(0)
    EmployeeFactory = chain.provider.get_base_contract_factory('Employee')
    employee_contract = EmployeeFactory(address=employee_contract_address)


    # Test paying employee contract directly
    assert foo.call().balanceOf(employee_contract.address) == 0
    chain.wait.for_receipt( foo.transact().transfer(employee_contract.address, 1))
    assert foo.call().balanceOf(employee_contract.address) == 1


def test_paying_employee(company_contract, token_contracts, accounts, chain, web3):
    foo, bar = token_contracts
    chain.wait.for_receipt( foo.transact().transfer(company_contract.address, 10))
    assert foo.call().balanceOf(company_contract.address) == 10
    assert company_contract
    employee_address = accounts[1]
    SALARY_USD = 100000
    tx = company_contract.transact().newEmployee(employee_address, SALARY_USD)
    chain.wait.for_receipt(tx)

    employee_contract_address = company_contract.call().getEmployee(0)
    EmployeeFactory = chain.provider.get_base_contract_factory('Employee')
    employee_contract = EmployeeFactory(address=employee_contract_address)

    chain.wait.for_receipt(employee_contract.transact().setAddresseAmount(foo.address,2))
    chain.wait.for_receipt(company_contract.transact().payEmployee(0))
    assert foo.call().balanceOf(company_contract.address) == 8
    assert foo.call().balanceOf(employee_contract_address) == 2



