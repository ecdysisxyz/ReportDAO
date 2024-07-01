// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../storage/Schema.sol";
import "../storage/Storage.sol";

library GlobalStateLib {
    function updateActiveUserCount() internal {
        Schema.GlobalState storage s = Storage.state();
        Schema.User storage u = s.users[msg.sender];

        if (u.lastActiveTimestamp > block.timestamp - 7 days) {
            u.lastActiveTimestamp = block.timestamp;
            u.activeHeartbeat++;
        } else {
            u.lastActiveTimestamp = block.timestamp;
            u.activeHeartbeat = 0;
            u.isActive = false;
            uint _newActiveUserCount = s.activeUserCount - 1;
            s.activeUserCount = _newActiveUserCount;
            s.quorum = _newActiveUserCount / 2;
        }

        if (u.activeHeartbeat > 12) {
            u.isActive = true;
            uint _newActiveUserCount = s.activeUserCount + 1;
            s.activeUserCount = _newActiveUserCount;
            s.quorum = _newActiveUserCount / 2;
        }
    }
}