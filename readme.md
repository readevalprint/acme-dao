[![Build Status](https://travis-ci.org/readevalprint/acme-dao.svg?branch=master)](https://travis-ci.org/readevalprint/acme-dao)


# AcmeDAO

A prototype distributed company with payouts via [ERC223 tokens](https://github.com/aragon/ERC23/)

# Goal

In the same way ERC20 and 23 (223 ?) have standardized how tokens are created and transfer
AcmeDAO hopes to standardize the interfaces between companies and employees.

Company:
 - Have a `address[] board_of_directors`
 - Set tokens they pay out in
 - require N of M directors to approve any changes
 - create Employees with a fixed salary
 - pays employees across their tokens based on their ratios

Employee:
 - Has an `authorized_address` (working title) which is the address that the employee manages their contract from
 - sets tokens they accecpt
 - set the payout ratio between tokens ex. ETH:30%, BTC:50%, UST:20%

# Usage

Right now, the easiest way to understand how to use it is to read the tests at `./tests/test_company.py`

# Development
Built in [populous](https://github.com/pipermerriam/populus).

Requires [solc 0.4.8](https://github.com/ethereum/solidity/tree/release_0.4.8) until this is fixed: https://github.com/pipermerriam/populus/issues/249
and optionally [docker-compose](https://docs.docker.com/compose/)

# Roadmap

- [x] Prototype with new ERC223 tokens
- [x] Write initial sanity tests
- [x] Set up CI build process
- [x] Flesh out high level interfaces
- [ ] Make the permissions more granual and allow the transfering ow company ownership
- [ ] Add checks that accepted tokens between Company and Employee are valid
- [ ] Document standardized Company, Employee contract interface
- [ ] Make simple js UI


# Testing

The easist way is to run with docker compose. It will mount the current directory so
any changes will be reflected in the tests without having to rebuild the container image.

```
docker-compose acme-dao test
```


Or if you have the requirements installed on your host:

```
py.test tests/
```

