// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { OwnershipComponent } from "@dk1a/solecslib/contracts/token/ERC721/components/OwnershipComponent.sol";
import { ownershipComponentID } from "./WNFTSystem.sol";
import { WNFTOwnership, WNFTOwnershipTableId } from "../codegen/tables/WNFTOwnership.sol";

library LibToken {
  error LibToken_MustBeTokenOwner();

  function ownerOf(uint256 tokenEntity) internal view returns (address) {
    bytes memory rawValue = WNFTOwnership.get(tokenEntity);
    if (rawValue.length == 0) {
      return address(0);
    }
    return abi.decode(rawValue, (address));
  }

  function requireOwner(uint256 tokenEntity, address account) internal view {
    if (account != ownerOf(tokenEntity)) {
      revert LibToken_MustBeTokenOwner();
    }
  }
}
