// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

import { CommonSystem } from "../../CommonSystem.sol";
import { revertWithBytes } from "@latticexyz/world/src/revertWithBytes.sol";
import { IWorldCall } from "@latticexyz/world/src/IWorldKernel.sol";
import { SystemCall } from "@latticexyz/world/src/SystemCall.sol";
import { WorldContextConsumerLib } from "@latticexyz/world/src/WorldContext.sol";
import { Systems } from "@latticexyz/world/src/codegen/tables/Systems.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";

type CommonSystemType is bytes32;

// equivalent to WorldResourceIdLib.encode({ typeId: RESOURCE_SYSTEM, namespace: "common", name: "CommonSystem" }))
CommonSystemType constant commonSystem = CommonSystemType.wrap(
  0x7379636f6d6d6f6e0000000000000000436f6d6d6f6e53797374656d00000000
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
 * @title CommonSystemLib
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This library is automatically generated from the corresponding system contract. Do not edit manually.
 */
library CommonSystemLib {
  error CommonSystemLib_CallingFromRootSystem();

  function setName(CommonSystemType self, bytes32 entity, string memory name) internal {
    return CallWrapper(self.toResourceId(), address(0)).setName(entity, name);
  }

  function setOwnedBy(CommonSystemType self, bytes32 entity, bytes32 ownerEntity) internal {
    return CallWrapper(self.toResourceId(), address(0)).setOwnedBy(entity, ownerEntity);
  }

  function setName(CallWrapper memory self, bytes32 entity, string memory name) internal {
    // if the contract calling this function is a root system, it should use `callAsRoot`
    if (address(_world()) == address(this)) revert CommonSystemLib_CallingFromRootSystem();

    bytes memory systemCall = abi.encodeCall(_setName_bytes32_string.setName, (entity, name));
    self.from == address(0)
      ? _world().call(self.systemId, systemCall)
      : _world().callFrom(self.from, self.systemId, systemCall);
  }

  function setOwnedBy(CallWrapper memory self, bytes32 entity, bytes32 ownerEntity) internal {
    // if the contract calling this function is a root system, it should use `callAsRoot`
    if (address(_world()) == address(this)) revert CommonSystemLib_CallingFromRootSystem();

    bytes memory systemCall = abi.encodeCall(_setOwnedBy_bytes32_bytes32.setOwnedBy, (entity, ownerEntity));
    self.from == address(0)
      ? _world().call(self.systemId, systemCall)
      : _world().callFrom(self.from, self.systemId, systemCall);
  }

  function setName(RootCallWrapper memory self, bytes32 entity, string memory name) internal {
    bytes memory systemCall = abi.encodeCall(_setName_bytes32_string.setName, (entity, name));
    SystemCall.callWithHooksOrRevert(self.from, self.systemId, systemCall, msg.value);
  }

  function setOwnedBy(RootCallWrapper memory self, bytes32 entity, bytes32 ownerEntity) internal {
    bytes memory systemCall = abi.encodeCall(_setOwnedBy_bytes32_bytes32.setOwnedBy, (entity, ownerEntity));
    SystemCall.callWithHooksOrRevert(self.from, self.systemId, systemCall, msg.value);
  }

  function callFrom(CommonSystemType self, address from) internal pure returns (CallWrapper memory) {
    return CallWrapper(self.toResourceId(), from);
  }

  function callAsRoot(CommonSystemType self) internal view returns (RootCallWrapper memory) {
    return RootCallWrapper(self.toResourceId(), WorldContextConsumerLib._msgSender());
  }

  function callAsRootFrom(CommonSystemType self, address from) internal pure returns (RootCallWrapper memory) {
    return RootCallWrapper(self.toResourceId(), from);
  }

  function toResourceId(CommonSystemType self) internal pure returns (ResourceId) {
    return ResourceId.wrap(CommonSystemType.unwrap(self));
  }

  function fromResourceId(ResourceId resourceId) internal pure returns (CommonSystemType) {
    return CommonSystemType.wrap(resourceId.unwrap());
  }

  function getAddress(CommonSystemType self) internal view returns (address) {
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

interface _setName_bytes32_string {
  function setName(bytes32 entity, string memory name) external;
}

interface _setOwnedBy_bytes32_bytes32 {
  function setOwnedBy(bytes32 entity, bytes32 ownerEntity) external;
}

using CommonSystemLib for CommonSystemType global;
using CommonSystemLib for CallWrapper global;
using CommonSystemLib for RootCallWrapper global;
