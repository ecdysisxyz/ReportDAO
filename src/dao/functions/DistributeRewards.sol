// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../storage/Schema.sol";
import "../storage/Storage.sol";

contract DistributeRewards {
    function distributeRewards() external {
        Schema.GlobalState storage s = Storage.state();
        require(!s.users[msg.sender].isBanned, "User is banned");

        uint256 totalRewards = 1000; // Example total reward amount
        uint256 activeUserCount = 0;

        // Calculate the number of active users
        for (uint256 i = 0; i < s.users.length; i++) {
            if (!s.users[i].isBanned && s.users[i].reportCount > 0) {
                activeUserCount++;
            }
        }

        // Distribute rewards equally among active users
        uint256 rewardPerUser = totalRewards / activeUserCount;
        for (uint256 i = 0; i < s.users.length; i++) {
            if (!s.users[i].isBanned && s.users[i].reportCount > 0) {
                s.rewards[s.users[i].userID].amount += rewardPerUser;
            }
        }

        emit RewardsDistributed();
    }

    event RewardsDistributed();
}