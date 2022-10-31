// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./token/ERC20.sol";
import "./access/Ownable.sol";

contract HipocratToken is ERC20, Ownable {
    // set upper limit as constant to prevent arbitrary minting
    uint256 public constant UPPER_LIMIT = 1250000000 * (10**18);
    // Hipocrat minted at creation
    constructor(uint256 initialSupply) ERC20("Hipocrat", "HPO") {
        _mint(msg.sender, initialSupply);
    }
    // ERC20 is mintable
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
    // ERC20 is burnable
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }
    function burnFrom(address account, uint256 amount) public {
        _spendAllowance(account, msg.sender, amount);
        _burn(account, amount);
    }
    // ERC20 is capped
    function _mint(address account, uint256 amount) internal override {
        require(ERC20.totalSupply() + amount <= UPPER_LIMIT, "ERC20Capped: cap exceeded");
        super._mint(account, amount);
    }
}