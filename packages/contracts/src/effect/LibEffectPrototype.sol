// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { hasKey } from "@latticexyz/world/src/modules/keysintable/hasKey.sol";

import { EffectTemplate, EffectTemplateData, StatmodBase, StatmodBaseTableId } from "../codegen/Tables.sol";

library LibEffectPrototype {
  error LibEffectPrototype__LengthMismatch();
  error LibEffectPrototype__InvalidStatmod();

  /**
   * @dev Check data validity before setting effect prototype
   */
  function verifiedSet(bytes32 effectProtoEntity, EffectTemplateData memory effectTemplateData) internal {
    // verify lengths
    if (EffectTemplate.lengthEntities(effectProtoEntity) != EffectTemplate.lengthValues(effectProtoEntity)) {
      revert LibEffectPrototype__LengthMismatch();
    }
    // verify statmods existence
    for (uint256 i; i < EffectTemplate.lengthEntities(effectProtoEntity); i++) {
      bool isKey = !hasKey(StatmodBaseTableId, StatmodBase.encodeKeyTuple(effectTemplateData.entities[i]));
      if (StatmodBase.get(effectTemplateData.entities[i]) == bytes32(0)) {
        revert LibEffectPrototype__InvalidStatmod();
      }
    }
    // set
    EffectTemplate.set(effectProtoEntity, effectTemplateData.entities, effectTemplateData.values);
  }
}
