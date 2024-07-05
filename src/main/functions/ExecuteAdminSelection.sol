// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../storage/Schema.sol";
import "../storage/Storage.sol";

contract ExecuteAdminSelection {
    function executeAdminSelection() external {
        Schema.GlobalState storage s = Storage.state();
        require(!$s.users[msg.sender].isBanned, "User is banned");

        uint256 totalStake = 0;
        address[] memory minHeap = new address[](55);  // Min-heap of size sqrt(3000) ≈ 55
        uint256 heapSize = 0;

        // Collect active users with stakes
        for (uint256 i = 0; i < $s.userList.length; i++) {
            address userAddress = $s.userList[i];
            if ($s.users[userAddress].isActive && $s.users[userAddress].stakeAmount > 0) {
                totalStake += $s.users[userAddress].stakeAmount;

                // Maintain min-heap of top 55 staked users
                if (heapSize < 55) {
                    minHeap[heapSize] = userAddress;
                    heapSize++;
                    if (heapSize == 55) {
                        buildMinHeap(minHeap, s);
                    }
                } else if ($s.users[userAddress].stakeAmount > $s.users[minHeap[0]].stakeAmount) {
                    minHeap[0] = userAddress;
                    minHeapify(minHeap, 0, s);
                }
            }
        }

        // Update admins with the addresses in minHeap
        for (uint256 i = 0; i < heapSize; i++) {
            $s.admins[minHeap[i]].userID = minHeap[i];
            $s.admins[minHeap[i]].stakeAmount = $s.users[minHeap[i]].stakeAmount;
        }

        emit AdminSelectionExecuted();
    }

    function buildMinHeap(address[] memory heap, Schema.GlobalState storage s) private {
        for (uint256 i = heap.length / 2; i > 0; i--) {
            minHeapify(heap, i - 1, s);
        }
    }

    function minHeapify(address[] memory heap, uint256 i, Schema.GlobalState storage s) private {
        uint256 left = 2 * i + 1;
        uint256 right = 2 * i + 2;
        uint256 smallest = i;

        if (left < heap.length && $s.users[heap[left]].stakeAmount < $s.users[heap[smallest]].stakeAmount) {
            smallest = left;
        }

        if (right < heap.length && $s.users[heap[right]].stakeAmount < $s.users[heap[smallest]].stakeAmount) {
            smallest = right;
        }

        if (smallest != i) {
            address temp = heap[i];
            heap[i] = heap[smallest];
            heap[smallest] = temp;
            minHeapify(heap, smallest, s);
        }
    }

    event AdminSelectionExecuted();
}