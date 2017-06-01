pragma solidity ^0.4.8;


import "./ERC23/implementation/Standard23Token.sol";

contract FooToken is Standard23Token {

	function () {
		throw;
	}

	uint8 public decimals = 1;  
	string public symbol = 'FOO';   

	function FooToken( uint256 _initialAmount) {
		balances[msg.sender] = _initialAmount;               // Give the creator all initial tokens
		totalSupply = _initialAmount;
	}
}

contract BarToken is Standard23Token {

	function () {
		throw;
	}

	uint8 public decimals = 1;  
	string public symbol = 'BAR';   

	function FooToken( uint256 _initialAmount) {
		balances[msg.sender] = _initialAmount;               // Give the creator all initial tokens
		totalSupply = _initialAmount;
	}
}

