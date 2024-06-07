// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { IBaseWorld } from "@latticexyz/world/src/codegen/interfaces/IBaseWorld.sol";
import { IERC721Mintable } from "@latticexyz/world-modules/src/modules/erc721-puppet/IERC721Mintable.sol";
import { ERC721MetadataData } from "@latticexyz/world-modules/src/modules/erc721-puppet/tables/ERC721Metadata.sol";

import { ROOT_NAMESPACE_ID } from "@latticexyz/world/src/constants.sol";
import { NamespaceOwner } from "@latticexyz/world/src/codegen/tables/NamespaceOwner.sol";

import { registerERC721 } from "@latticexyz/world-modules/src/modules/erc721-puppet/registerERC721.sol";

import { GameConfig } from "../codegen/index.sol";

import { wandererTokenName, wandererTokenSymbol, wandererTokenURI } from "../CustomTypes.sol";

library LibInitToken {
  function init(bytes14 namespace) public {
    IERC721Mintable tokenAddress = _add(wandererTokenName, wandererTokenSymbol, wandererTokenURI, namespace);
    uint256 tokenId = uint256(uint160(tokenAddress));
    address admin = NamespaceOwner.get(ROOT_NAMESPACE_ID);

    GameConfig.set(admin, tokenAddress, tokenId, namespace);
  }

  function _add(
    string memory name,
    string memory symbol,
    string memory URI,
    bytes14 namespace
  ) private returns (IERC721Mintable escapedStumpToken) {
    escapedStumpToken = registerERC721(
      world,
      namespace,
      ERC721MetadataData({ name: name, symbol: symbol, aseURI: URI })
    );
  }
}
