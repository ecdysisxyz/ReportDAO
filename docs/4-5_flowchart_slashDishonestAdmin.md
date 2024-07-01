```mermaid
flowchart TD
    A[Start] --> B[Check if Rejector is Banned]
    B -->|No| C[Check if Admin Exists]
    C --> D{Does Admin Exist?}
    D -->|Yes| E[Check Admin's Stake Amount]
    E --> F{Is Stake Amount > 0?}
    F -->|Yes| G[Burn Admin's Stake Tokens]
    G --> H[Update Admin's Stake Amount to 0]
    H --> I[Emit AdminSlashed Event]
    I --> J[Reflect Global State]
    J --> K[End]
    F -->|No| L[Revert Transaction]
    L --> K
    D -->|No| M[Revert Transaction]
    M --> K
    B -->|Yes|







