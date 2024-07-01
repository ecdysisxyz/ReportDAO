// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../storage/Schema.sol";
import "../storage/Storage.sol";

contract CreateLock {
    function createLock(uint256 amount, uint256 unlockTime) external {
        Schema.GlobalState storage s = Storage.state();
        require(!s.users[msg.sender].isBanned, "User is banned");

        // Implement the logic to lock tokens
        // ...

        emit LockCreated(msg.sender, amount, unlockTime);
    }

    event LockCreated(address indexed user, uint256 amount, uint256 unlockTime);
}