// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { IWorld } from "../codegen/world/IWorld.sol";
import { IERC721Mintable } from "@latticexyz/world-modules/src/modules/erc721-puppet/IERC721Mintable.sol";
import { ERC721MetadataData } from "@latticexyz/world-modules/src/modules/erc721-puppet/tables/ERC721Metadata.sol";

import { ROOT_NAMESPACE_ID } from "@latticexyz/world/src/constants.sol";
import { NamespaceOwner } from "@latticexyz/world/src/codegen/tables/NamespaceOwner.sol";

import { registerERC721 } from "@latticexyz/world-modules/src/modules/erc721-puppet/registerERC721.sol";

import { GameConfig } from "../codegen/index.sol";

library LibInitToken {
  function init(bytes14 namespace, address worldAddress) internal {
    IERC721Mintable tokenAddress = _add("Wanderer NFT", "WNFT", "", namespace, worldAddress);

    GameConfig.set(address(tokenAddress), namespace);
  }

  function _add(
    string memory name,
    string memory symbol,
    string memory URI,
    bytes14 namespace,
    address worldAddress
  ) private returns (IERC721Mintable tokenAddress) {
    IWorld world = IWorld(worldAddress);

    tokenAddress = registerERC721(world, namespace, ERC721MetadataData({ name: name, symbol: symbol, baseURI: URI }));
  }
}
