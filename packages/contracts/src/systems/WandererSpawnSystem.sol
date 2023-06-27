// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { getUniqueEntity } from "@latticexyz/world/src/modules/uniqueentity/getUniqueEntity.sol";

import { WNFTOwnership, DefaultWheel, Wanderer, GuisePrototype } from "../codegen/Tables.sol";

//import { LibCycle } from "../cycle/LibCycle.sol";

/// @title Spawn a wandererEntity and start a cycle for it.
/// @dev This is for new players, whereas StartCycleSystem is for existing ones.
contract WandererSpawnSystem is System {
  error WandererSpawnSystem__InvalidGuise();

  /// @notice Anyone can freely spawn wanderers, a wanderer is a tokenized game account
  function spawnWanderer(bytes32 guiseProtoEntity) public override returns (bytes32 wandererEntity) {
    bytes32 guiseProtoDecoded = abi.decode(guiseProtoEntity);

    // mint nft
    bytes32 wandererEntity = getUniqueEntity();
    //    WNFTSystem wnftSystem = WNFTSystem(getAddressById(world.systems(), WNFTSystemID));
    //    wnftSystem.executeSafeMint(msg.sender, wandererEntity, "");

    // flag the entity as wanderer
    Wanderer.set(wandererEntity, true);

    bytes32 defaultWheelEntity = DefaultWheel.get();

    // init cycle
    //    LibCycle.initCycle(wandererEntity, guiseProtoDecoded, defaultWheelEntity);

    return abi.decode(abi.encode(wandererEntity));
  }
}
