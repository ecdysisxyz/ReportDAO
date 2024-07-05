// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../storage/Schema.sol";
import "../storage/Storage.sol";
import "../utils/GlobalStateLib.sol";

contract ClaimReward {
    function claimReward() external {
        Schema.GlobalState storage s = Storage.state();
        require(!s.users[msg.sender].isBanned, "User is banned");

        uint256 rewardAmount = s.rewards[msg.sender].amount;
        require(rewardAmount > 0, "No rewards to claim");

        s.rewards[msg.sender].amount = 0;
        payable(msg.sender).transfer(rewardAmount);
        GlobalStateLib.updateActiveUserCount();

        emit RewardClaimed(msg.sender, rewardAmount);
    }

    event RewardClaimed(address indexed user, uint256 amount);
}