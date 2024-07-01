```mermaid
sequenceDiagram
    participant Keeper
    participant Protocol
    participant GlobalStateLib

    Keeper->>Protocol: executeAdminSelection()
    Protocol->>Protocol: Check if User is Banned
    Protocol-->>Keeper: Revert Transaction (if banned)
    Protocol->>Protocol: Initialize Min-Heap
    loop Loop Through Participants
        Protocol->>Protocol: Check if User is Active
        alt User is Active
            Protocol->>Protocol: Check if User Has Stake
            alt User Has Stake
                Protocol->>Protocol: Add to Min-Heap
                Protocol->>Protocol: Is Heap Full?
                alt Heap is Full
                    Protocol->>Protocol: Replace Min if Current Stake is Greater
                    Protocol->>Protocol: Heapify Min-Heap
                end
            end
        end
    end
    Protocol->>Protocol: Update Admin List with Heap
    Protocol->>Keeper: Emit AdminSelectionExecuted Event
    Protocol->>GlobalStateLib: Reflect Global State
    GlobalStateLib-->>Protocol: State Updated
    Protocol->>Keeper: Transaction Complete