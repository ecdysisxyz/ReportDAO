```mermaid
flowchart TD
    A[Start] --> B[Check if User is Banned]
    B -->|No| C[Check Allowance]
    C --> D{Is Allowance >= Amount?}
    D -->|Yes| E[Transfer Tokens from User]
    E --> F{Did Transfer Succeed?}
    F -->|Yes| G[Lock Tokens in Contract]
    G --> H[Store Lock Data]
    H --> I[Emit LockCreated Event]
    I --> J[Reflect Global State]
    J --> K[End]
    D -->|No| L[Revert Transaction]
    L --> K
    F -->|No| M[Revert Transaction]
    M --> K
    B -->|Yes| N[Revert Transaction]
    N --> K