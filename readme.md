[![Build Status](https://travis-ci.org/readevalprint/acme-dao.svg?branch=master)](https://travis-ci.org/readevalprint/acme-dao)


# AcmeDAO

A prototype distributed company with payouts via [ERC223 tokens](https://github.com/aragon/ERC23/)

# Usage

Right now, the easiest way to understand how to use it is to read the tests at `./tests/test_company.py`

# Development
Built in [populous](https://github.com/pipermerriam/populus).

Requires [solc 0.4.8](https://github.com/ethereum/solidity/tree/release_0.4.8) until this is fixed: https://github.com/pipermerriam/populus/issues/249
and optionally [docker-compose](https://docs.docker.com/compose/)


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

