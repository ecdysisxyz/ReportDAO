```mermaid
sequenceDiagram
    participant Keeper
    participant Protocol

    Keeper->>Protocol: distributeRewards()
    Protocol->>Protocol: Check if User is Banned
    Protocol-->>Keeper: Revert Transaction (if banned)
    Protocol->>Protocol: Execute Reward Distribution Logic
    Protocol->>Protocol: Update User Reward Balances
    Protocol->>Keeper: Emit RewardsDistributed Event
    Protocol->>Protocol: Reflect Global State