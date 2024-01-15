// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { getUniqueEntity } from "@latticexyz/world-modules/src/modules/uniqueentity/getUniqueEntity.sol";

import { RNGPrecommit, RNGRequestOwner } from "../codegen/index.sol";

/// @dev Simple blockhash rng.
/// Get requestId from `requestRandomness`, then after `WAIT_BLOCKS` call `getRandomness` with that requestId.
/// Do not reuse the same requestId, otherwise it can be predictable.
///
/// on-chain try+discard - solved with precommits to future block numbers.
/// 256 past blocks limit - ignored. Build UX around it.
/// MEV - ignored. Don't use this for high stakes.
///
/// TODO consider prevrandao, VRF, eip-2935
library LibRNG {
  error LibRNG__InvalidPrecommit();
  error LibRNG__NotRequestOwner();

  // TODO 0 wait allows 2 txs in a row really fast and is great during local dev, but not exactly safe
  // (note that this does not allow same-block retrieval - you can't get current blockhash)
  uint256 constant WAIT_BLOCKS = 0;

  function requestRandomness(bytes32 requestOwnerEntity) internal returns (bytes32 requestId) {
    bytes32 requestId = getUniqueEntity();

    RNGPrecommit.set(requestId, block.number + WAIT_BLOCKS);

    RNGRequestOwner.set(requestId, requestOwnerEntity);

    return requestId;
  }

  function getRandomness(bytes32 requestOwnerEntity, bytes32 requestId) internal view returns (uint256 randomness) {
    if (requestOwnerEntity != RNGRequestOwner.get(requestId)) {
      revert LibRNG__NotRequestOwner();
    }
    uint256 precommit = RNGPrecommit.get(requestId);

    if (!isValid(precommit)) revert LibRNG__InvalidPrecommit();

    return uint256(blockhash(precommit));
  }

  function isValid(uint256 precommit) internal view returns (bool) {
    return
      // must be initialized
      precommit != 0 &&
      // and past the precommitted-to-block
      precommit < block.number &&
      // and not too far past it because blockhash only works for 256 most recent blocks
      !isOverBlockLimit(precommit);
  }

  function isOverBlockLimit(uint256 precommit) internal view returns (bool) {
    return block.number > precommit + 256;
  }
}