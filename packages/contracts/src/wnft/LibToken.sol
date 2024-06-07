// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { Owners } from "@latticexyz/world-modules/src/modules/erc721-puppet/tables/Owners.sol";
import { TokenURI } from "@latticexyz/world-modules/src/modules/erc721-puppet/tables/TokenURI.sol";

import { _tokenUriTableId } from "@latticexyz/world-modules/src/modules/erc721-puppet/utils.sol";
import { _ownersTableId } from "@latticexyz/world-modules/src/modules/erc721-puppet/utils.sol";

import { GameConfig } from "../codegen/index.sol";

library LibToken {
  error LibToken_MustBeTokenOwner();

  function tokenURI() internal view returns (string memory) {
    uint256 tokenId = GameConfig.getTokenId();
    bytes14 namespace = GameConfig.getNamespace();

    string memory uri = TokenURI.get(_tokenUriTableId(namespace), tokenId);
    return uri;
  }

  function ownerOf() internal view returns (address) {
    uint256 tokenId = GameConfig.getTokenId();
    bytes14 namespace = GameConfig.getNamespace();

    address addr = Owners.get(_ownersTableId(namespace), tokenId);
    return addr;
  }

  function requireOwner(address account) internal view {
    if (account != ownerOf()) {
      revert LibToken_MustBeTokenOwner();
    }
  }
}
