// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { getUniqueEntity } from "@latticexyz/world/src/modules/uniqueentity/getUniqueEntity.sol";

import { Wheel, DefaultWheel, Name, WheelData } from "../codegen/Tables.sol";

library LibInitWheel {
  error GuisePrototypeInitSystem__InvalidSkill();

  function init(IWorld world) internal {
    bytes32 wheelEntity = add(
      "Wheel of Attainment",
      WheelData({ totalIdentityRequired: 0, charges: 3, isIsolated: false })
    );

    DefaultWheel.set(wheelEntity);

    add("Wheel of Isolation", WheelData({ totalIdentityRequired: 128, charges: 4, isIsolated: true }));
  }

  function add(string memory name, WheelData memory wheelData) internal returns (bytes32 entity) {
    bytes32 entity = getUniqueEntity();

    Wheel.set(entity, wheelData);
    Name.set(entity, name);
  }
}
