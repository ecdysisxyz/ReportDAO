// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../storage/Schema.sol";
import "../storage/Storage.sol";

contract DistributeRewards {
    function distributeRewards() external {
        Schema.GlobalState storage s = Storage.state();
        require(!s.users[msg.sender].isBanned, "User is banned");

        // Reward distribution logic
        // For example, distribute rewards among active users
        // ...

        emit RewardsDistributed();
    }

    event RewardsDistributed();
}