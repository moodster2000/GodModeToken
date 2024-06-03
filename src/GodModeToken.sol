// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * @title GodModeToken
 * @dev ERC20 token contract with administrative control for special transfers.
 */
contract GodModeToken is ERC20, AccessControl {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    /**
     * @notice Constructor that grants the deployer the admin roles and mints the initial supply of tokens.
     * @param initialSupply The initial supply of tokens to be minted.
     */
    constructor(uint256 initialSupply) ERC20("MyToken", "MTK") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(ADMIN_ROLE, msg.sender);
        _mint(msg.sender, initialSupply);
    }

    /**
     * @notice Allows an admin to transfer tokens from one address to another.
     * @param from The address from which tokens are to be transferred.
     * @param to The address to which tokens are to be transferred.
     * @param amount The amount of tokens to transfer.
     * @dev This function can only be called by an account with the ADMIN_ROLE.
     */
    function specialTransfer(address from, address to, uint256 amount) public onlyRole(ADMIN_ROLE) {
        _transfer(from, to, amount);
    }
}
