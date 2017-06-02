[![Build Status](https://travis-ci.org/readevalprint/acme-dao.svg?branch=master)](https://travis-ci.org/readevalprint/acme-dao)


# AcmeDAO

A prototype distributed company with payouts via [ERC223 tokens](https://github.com/aragon/ERC23/)

# Goal

In the same way ERC20 and 23 (223 ?) have standardized how tokens are created and transfered,
AcmeDAO hopes to standardize the interfaces between companies and employees.

Company:
 - Have a `address[] board_of_directors`
 - Set tokens they pay out in
 - require N of M directors to approve any changes
 - create Employees with a fixed salary
 - pays employees across their tokens based on their ratios

Employee:
 - Has an `authorized_address` (working title) which is the address that the employee manages their contract from
 - sets tokens they accept
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
- [ ] Make the permissions more granular and allow the transferring of company ownership
- [ ] Add checks that accepted tokens between Company and Employee are valid
- [ ] Document standardized Company, Employee contract interface
- [ ] Make simple js UI

# Sponsors


### ===> $YOUR_LOGO_HERE <===

If you want to gain visibility for your own amazing (and possibly soon to be autonomously distributed) company, please send me a message [@readevalprint](https://twitter.com/readevalprint/)

Alternatively, if there is a feature that you prioritize but is not listed
on the roadmap, please make an issue and your requirements and I will quote you a price.

# Testing

The easiest way toe run the testsuit is with docker-compose. It will automatically mount the current directory so
any changes will be reflected in the tests without having to rebuild the container image. Read the [docker-compose.yml](./docker-compose.yaml)

```
docker-compose acme-dao test
```

Or if you have the requirements installed on your host:

```
py.test tests/
```


# MIT License

Copyright 2017 Timothy Watts (tim@readevalprint.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
