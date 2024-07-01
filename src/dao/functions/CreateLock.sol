// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../storage/Schema.sol";
import "../storage/Storage.sol";
import "../utils/GlobalStateLib.sol";

contract CreateLock {
    function createLock(uint256 amount, uint256 unlockTime) external {
        Schema.GlobalState storage s = Storage.state();
        require(!s.users[msg.sender].isBanned, "User is banned");

        // Check allowance
        uint256 allowance = token.allowance(msg.sender, address(this));
        require(allowance >= amount, "Allowance not sufficient");

        // Transfer tokens from user to this contract
        require(token.transferFrom(msg.sender, address(this), amount), "Token transfer failed");

        // Lock tokens logic
        s.users[msg.sender].stakeAmount += amount;
        GlobalStateLib.activeUserCount();

        emit LockCreated(msg.sender, amount, unlockTime);
    }

    event LockCreated(address indexed user, uint256 amount, uint256 unlockTime);
}