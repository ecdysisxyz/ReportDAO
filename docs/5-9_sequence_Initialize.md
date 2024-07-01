```mermaid
sequenceDiagram
    participant Deployer
    participant Protocol

    Deployer->>Protocol: initialize(tokenAddr)
    Protocol->>Protocol: Check if already initialized
    Protocol-->>Deployer: Revert Transaction (if already initialized)
    Protocol->>Protocol: Set token address
    Protocol->>Deployer: Emit Initialized Event