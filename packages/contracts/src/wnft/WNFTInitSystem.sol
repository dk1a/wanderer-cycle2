// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { IBaseWorld } from "@latticexyz/world/src/codegen/interfaces/IBaseWorld.sol";
import { IERC721Mintable } from "@latticexyz/world-modules/src/modules/erc721-puppet/IERC721Mintable.sol";
import { ERC721MetadataData } from "@latticexyz/world-modules/src/modules/erc721-puppet/tables/ERC721Metadata.sol";

import { getUniqueEntity } from "@latticexyz/world-modules/src/modules/uniqueentity/getUniqueEntity.sol";

import { System } from "@latticexyz/world/src/System.sol";
import { registerERC721 } from "@latticexyz/world-modules/src/modules/erc721-puppet/registerERC721.sol";

import { WANDERER_TOKEN } from "../CustomTypes.sol";
import { WNFTOwnership } from "../codegen/index.sol";

contract WNFTInitSystem is System {
  function init(IBaseWorld world) public {
    bytes32 token = getUniqueEntity();

    IERC721Mintable escapedStumpToken = registerERC721(
      world,
      WANDERER_TOKEN,
      ERC721MetadataData({ name: "wanderer-cycle non-fungible tokens", symbol: "WNFT", baseURI: "" })
    );

    WNFTOwnership.set(token, address(escapedStumpToken));
  }
}
