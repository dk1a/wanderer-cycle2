// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

import { CancelCycleSystem } from "../../cycle/CancelCycleSystem.sol";
import { revertWithBytes } from "@latticexyz/world/src/revertWithBytes.sol";
import { IWorldCall } from "@latticexyz/world/src/IWorldKernel.sol";
import { SystemCall } from "@latticexyz/world/src/SystemCall.sol";
import { WorldContextConsumerLib } from "@latticexyz/world/src/WorldContext.sol";
import { Systems } from "@latticexyz/world/src/codegen/tables/Systems.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";

type CancelCycleSystemType is bytes32;

// equivalent to WorldResourceIdLib.encode({ typeId: RESOURCE_SYSTEM, namespace: "", name: "CancelCycleSyste" }))
CancelCycleSystemType constant cancelCycleSystem = CancelCycleSystemType.wrap(
  0x7379000000000000000000000000000043616e63656c4379636c655379737465
);

struct CallWrapper {
  ResourceId systemId;
  address from;
}

struct RootCallWrapper {
  ResourceId systemId;
  address from;
}

/**
 * @title CancelCycleSystemLib
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This library is automatically generated from the corresponding system contract. Do not edit manually.
 */
library CancelCycleSystemLib {
  error CancelCycleSystemLib_CallingFromRootSystem();

  function cancelCycle(CancelCycleSystemType self, bytes32 cycleEntity) internal {
    return CallWrapper(self.toResourceId(), address(0)).cancelCycle(cycleEntity);
  }

  function cancelCycle(CallWrapper memory self, bytes32 cycleEntity) internal {
    // if the contract calling this function is a root system, it should use `callAsRoot`
    if (address(_world()) == address(this)) revert CancelCycleSystemLib_CallingFromRootSystem();

    bytes memory systemCall = abi.encodeCall(_cancelCycle_bytes32.cancelCycle, (cycleEntity));
    self.from == address(0)
      ? _world().call(self.systemId, systemCall)
      : _world().callFrom(self.from, self.systemId, systemCall);
  }

  function cancelCycle(RootCallWrapper memory self, bytes32 cycleEntity) internal {
    bytes memory systemCall = abi.encodeCall(_cancelCycle_bytes32.cancelCycle, (cycleEntity));
    SystemCall.callWithHooksOrRevert(self.from, self.systemId, systemCall, msg.value);
  }

  function callFrom(CancelCycleSystemType self, address from) internal pure returns (CallWrapper memory) {
    return CallWrapper(self.toResourceId(), from);
  }

  function callAsRoot(CancelCycleSystemType self) internal view returns (RootCallWrapper memory) {
    return RootCallWrapper(self.toResourceId(), WorldContextConsumerLib._msgSender());
  }

  function callAsRootFrom(CancelCycleSystemType self, address from) internal pure returns (RootCallWrapper memory) {
    return RootCallWrapper(self.toResourceId(), from);
  }

  function toResourceId(CancelCycleSystemType self) internal pure returns (ResourceId) {
    return ResourceId.wrap(CancelCycleSystemType.unwrap(self));
  }

  function fromResourceId(ResourceId resourceId) internal pure returns (CancelCycleSystemType) {
    return CancelCycleSystemType.wrap(resourceId.unwrap());
  }

  function getAddress(CancelCycleSystemType self) internal view returns (address) {
    return Systems.getSystem(self.toResourceId());
  }

  function _world() private view returns (IWorldCall) {
    return IWorldCall(StoreSwitch.getStoreAddress());
  }
}

/**
 * System Function Interfaces
 *
 * We generate an interface for each system function, which is then used for encoding system calls.
 * This is necessary to handle function overloading correctly (which abi.encodeCall cannot).
 *
 * Each interface is uniquely named based on the function name and parameters to prevent collisions.
 */

interface _cancelCycle_bytes32 {
  function cancelCycle(bytes32 cycleEntity) external;
}

using CancelCycleSystemLib for CancelCycleSystemType global;
using CancelCycleSystemLib for CallWrapper global;
using CancelCycleSystemLib for RootCallWrapper global;
