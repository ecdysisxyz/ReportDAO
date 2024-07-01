```mermaid
flowchart TD
    A[Start] --> B[Check if User is Banned]
    B -->|No| C[Execute Reward Distribution Logic]
    C --> D[Update User Reward Balances]
    D --> E[Emit RewardsDistributed Event]
    F --> G[End]
    B -->|Yes| H[Revert Transaction]
    H --> G