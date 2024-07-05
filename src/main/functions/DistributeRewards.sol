// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../storage/Schema.sol";
import "../storage/Storage.sol";
import "../utils/GlobalStateLib.sol";

contract DistributeRewards {
    function distributeRewards() external {
        Schema.GlobalState storage $s = Storage.state();
        require(!$s.users[msg.sender].isBanned, "User is banned");

        uint256 totalRewards = 1000; // Example total reward amount
        uint256 activeUserCount = $s.activeUserCount;

        uint256 rewardPerUser = totalRewards / activeUserCount;
        for (uint256 i = 0; i < $s.userList.length; i++) {
            if ($s.users[$s.userList[i]].isActive) {
                $s.rewards[$s.userList[i]].amount += rewardPerUser;
            }
        }

        emit RewardsDistributed();
    }

    event RewardsDistributed();
}