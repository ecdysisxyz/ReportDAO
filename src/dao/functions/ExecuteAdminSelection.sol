// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../storage/Schema.sol";
import "../storage/Storage.sol";

contract ExecuteAdminSelection {
    function executeAdminSelection() external {
        Schema.GlobalState storage s = Storage.state();
        require(!s.users[msg.sender].isBanned, "User is banned");

        uint256 totalStake = 0;
        address[] memory candidates;
        uint256 candidateCount = 0;

        // Collect active users with stakes
        for (uint256 i = 0; i < s.userList.length; i++) {
            address userAddress = s.userList[i];
            if (s.users[userAddress].isActive && s.users[userAddress].stakeAmount > 0) {
                totalStake += s.users[userAddress].stakeAmount;
                candidates[candidateCount] = userAddress;
                candidateCount++;
            }
        }

        // Sort candidates by stake amount (in descending order)
        for (uint256 i = 0; i < candidateCount; i++) {
            for (uint256 j = i + 1; j < candidateCount; j++) {
                if (s.users[candidates[i]].stakeAmount < s.users[candidates[j]].stakeAmount) {
                    address temp = candidates[i];
                    candidates[i] = candidates[j];
                    candidates[j] = temp;
                }
            }
        }

        // Select top candidates as admins
        uint256 adminCount = uint256(sqrt(candidateCount));
        for (uint256 i = 0; i < adminCount; i++) {
            s.admins[candidates[i]].userID = candidates[i];
            s.admins[candidates[i]].stakeAmount = s.users[candidates[i]].stakeAmount;
        }

        emit AdminSelectionExecuted();
    }

    function sqrt(uint256 x) private pure returns (uint256) {
        uint256 z = (x + 1) / 2;
        uint256 y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
        return y;
    }

    event AdminSelectionExecuted();
}