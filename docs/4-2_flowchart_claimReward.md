```mermaid
flowchart TD
    A[Start] --> B[Check if User is Banned]
    B -->|No| C[Check User's Reward Balance]
    C --> D{Is Balance > 0?}
    D -->|Yes| E[Transfer Reward to User]
    E --> F[Reset User's Reward Balance]
    F --> G[Emit RewardClaimed Event]
    G --> H[Reflect Global State]
    H --> I[End]
    D -->|No| J[Revert Transaction]
    J --> I
    B -->|Yes| K[Revert Transaction]
    K --> I