```mermaid
flowchart TD
    A[Start] --> B[Check if User is Banned]
    B -->|No| C[Initialize Min-Heap]
    C --> D[Loop Through Participants]
    D --> E[Check if User is Active]
    E --> F[Check if User Has Stake]
    F -->|Yes| G[Add to Min-Heap]
    F -->|No| D
    E -->|No| D
    G --> H[Is Heap Full?]
    H -->|No| D
    H -->|Yes| I[Replace Min if Current Stake is Greater]
    I --> J[Heapify Min-Heap]
    J --> D
    D -->|End Loop| K[Update Admin List with Heap]
    K --> L[Emit AdminSelectionExecuted Event]
    L --> M[Reflect Global State]
    M --> N[End]
    B -->|Yes| O[Revert Transaction]
    O --> N