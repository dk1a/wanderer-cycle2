// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { getKeysWithValue } from "@latticexyz/world/src/modules/keyswithvalue/getKeysWithValue.sol";

import { StatmodBase, FromStatmodBase, StatmodBaseOpts, StatmodScope, StatmodValue } from "../codegen/Tables.sol";

/**
 * @title Scoped statmod values with aggregation depending on prototype.
 */
library Statmod {
  error Statmod_IncreaseByZero();
  error Statmod_DecreaseByZero();
  error Statmod_EntityAbsent();

  /**
   * @dev Increase statmod value for targeted baseEntity.
   */
  function increase(uint256 targetEntity, uint256 baseEntity, uint256 value) internal returns (bool isUpdate) {
    if (value == 0) revert Statmod_IncreaseByZero();

    uint32 storedValue = StatmodValue.get(targetEntity, baseEntity);

    bytes32 statmodBase = StatmodBase.get(baseEntity);

    isUpdate = storedValue != 0;
    if (statmodBase != StatmodScope.get(targetEntity, baseEntity)) {
      StatmodScope.set(targetEntity, baseEntity, statmodBase);
    }
    StatmodValue.set(targetEntity, baseEntity, storedValue + value);

    return isUpdate;
  }

  /**
   * @dev Decrease statmod value for targeted baseEntity.
   */
  function decrease(uint256 targetEntity, uint256 baseEntity, uint256 value) internal returns (bool isUpdate) {
    if (value == 0) revert ScopedValue__DecreaseByZero();

    uint32 storedValue = StatmodValue.get(targetEntity, baseEntity);
    if (storedValue == 0) revert ScopedValue__EntityAbsent();

    bytes32 statmodBase = StatmodBase.get(baseEntity);

    isUpdate = storedValue > value;
    if (statmodBase != StatmodScope.get(targetEntity, baseEntity)) {
      StatmodScope.set(targetEntity, baseEntity, statmodBase);
    }
    if (isUpdate) {
      StatmodValue.set(targetEntity, baseEntity, storedValue - value);
    } else {
      StatmodValue.deleteRecord(targetEntity, baseEntity);
    }

    return isUpdate;
  }
}
