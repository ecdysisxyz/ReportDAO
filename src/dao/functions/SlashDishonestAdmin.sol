// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../storage/Schema.sol";
import "../storage/Storage.sol";

contract SlashDishonestAdmin {
    function slashDishonestAdmin(address admin) external {
        Schema.GlobalState storage s = Storage.state();
        require(!s.users[msg.sender].isBanned, "Rejector is banned");

        Schema.Admin storage adminData = s.admins[admin];
        require(adminData.userID == admin, "Admin does not exist");

        // Slash admin's stake logic
        s.users[admin].stakeAmount = 0;

        emit AdminSlashed(admin);
    }

    event AdminSlashed(address indexed admin);
}