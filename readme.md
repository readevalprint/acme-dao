[![Build Status](https://travis-ci.org/readevalprint/acme-dao.svg?branch=master)](https://travis-ci.org/readevalprint/acme-dao)


# AcmeDAO

A prototype distributed company with payouts via [ERC223 tokens](https://github.com/aragon/ERC23/)


# Development
Built in [populous](https://github.com/pipermerriam/populus)
Requires solc 0.4.8 until this is fixed: https://github.com/pipermerriam/populus/issues/249
Optionally [docker-compose](https://docs.docker.com/compose/)

# Testing

The easist way is to run

```
docker-compose acme-dao test
```

Or if you have the requirments instal on your host

```
py.test tests/
```

