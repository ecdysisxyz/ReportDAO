# Report DAO

## For AI
`cat docs/* src/dao/functions/* src/dao/storage/* src/dao/utils/* | pbcopy` to get full dump of this project.

## Overview
ReportDAO is a decentralized protocol designed to maintain the integrity and safety of communities through user-generated reports and a robust reward system. It leverages the ERC-7546 Upgradeable Clone Standard to ensure modularity, upgradeability, and scalability.

## Key Features
- **User-Generated Reports**: Users can report safety issues by providing descriptions, locations, and photos.
- **Reward System**: Users are incentivized to report valid issues through a reward mechanism.
- **Admin and Keeper Roles**: Administrators can reject false reports and ban users, while Keepers manage reward distribution and admin selection.
- **Slash Mechanism**: Dishonest admins can be penalized by reducing their stake.
- **Upgradeable and Clonable Contracts**: The protocol supports upgradeability and the creation of new instances without redeploying the entire codebase.

## User Personas and Functions
### Safety Reporter
- **Report a Safety Issue**: `reportSafetyIssue(string memory description, string memory location, bytes memory photo)`
- **Claim a Reward**: `claimReward()`
- **Create a Lock**: `createLock(uint amount, uint unlockTime)`

### Administrator
- **Reject Report and Ban User**: `rejectReportAndBan(address reporter, uint256 reportId)`

### Rejector
- **Slash Dishonest Admin**: `slashDishonestAdmin(address admin)`

### Keeper
- **Execute Admin Selection**: `executeAdminSelection()`
- **Distribute Rewards**: `distributeRewards()`

### Deployer
- **Initialize Protocol**: `initialize(address tokenAddr)`

## Architecture
See `./docs` and there are full diagrams of this system.



---

# Meta Contract Template
Welcome to the Meta Contract Template! This template is your fast track to smart contract development, offering a pre-configured setup with the [Meta Contract](https://github.com/metacontract/mc) framework and essential tools like the [ERC-7201 Storage Location Calculator](https://github.com/metacontract/erc7201). It's designed for developers looking to leverage advanced features and best practices right from the start.

## Quick Start
Ensure you have [Foundry](https://github.com/foundry-rs/foundry) installed, then initialize your project with:
```sh
$ forge init <Your Project Name> -t metacontract/template
```
This command sets up your environment with all the benefits of the meta contract framework, streamlining your development process.

## Features
- Pre-integrated with meta contract for optimal smart contract development with highly flexible upgradeability & maintainability.
- Includes ERC-7201 Storage Location Calculator for calculating storage locations based on ERC-7201 names for enhanced efficiency.
- Ready-to-use project structure for immediate development start.

For detailed documentation and further guidance, visit [Meta Contract Book](https://mc-book.ecdysis.xyz/).

Start building your decentralized applications with meta contract today and enjoy a seamless development experience!
