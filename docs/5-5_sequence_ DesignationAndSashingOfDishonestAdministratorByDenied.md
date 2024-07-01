```mermaid
sequenceDiagram
    participant Rejector
    participant TokenContract
    participant Protocol
    participant Administrator

    Rejector->>Protocol: slashDishonestAdmin(admin)
    Protocol->>Protocol: Check if Rejector is Banned
    Protocol-->>Rejector: Revert Transaction (if banned)
    Protocol->>Protocol: Check if Admin Exists
    Protocol-->>Rejector: Revert Transaction (if admin does not exist)
    Protocol->>Protocol: Check Admin's Stake Amount
    Protocol-->>Rejector: Revert Transaction (if stake amount == 0)
    Protocol->>TokenContract: Burn Admin's Stake Tokens
    TokenContract-->>Protocol: Confirm Burn
    Protocol->>Protocol: Update Admin's Stake Amount to 0
    Protocol->>Rejector: Emit AdminSlashed Event
    Protocol->>Protocol: Reflect Global State