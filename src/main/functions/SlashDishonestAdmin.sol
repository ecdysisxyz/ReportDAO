// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../storage/Schema.sol";
import "../storage/Storage.sol";
import "../utils/GlobalStateLib.sol";

contract SlashDishonestAdmin {
    function slashDishonestAdmin(address admin) external {
        Schema.GlobalState storage $s = Storage.state();
        IERC20 token = IERC20($s.tokenAddress);
        require(!$s.users[msg.sender].isBanned, "Rejector is banned");

        Schema.Admin storage adminData = $s.admins[admin];
        require(adminData.userID == admin, "Admin does not exist");

        uint256 stakeAmount = $s.users[admin].stakeAmount;
        require(stakeAmount > 0, "No stake to slash");

        require(token.transfer(address(0), stakeAmount), "Token burn failed");

        $s.users[admin].stakeAmount = 0;
        GlobalStateLib.updateActiveUserCount();

        emit AdminSlashed(admin, stakeAmount);
    }

    event AdminSlashed(address indexed admin, uint256 amount);
}