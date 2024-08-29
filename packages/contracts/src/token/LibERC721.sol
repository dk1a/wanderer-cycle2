// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { Owners } from "@latticexyz/world-modules/src/modules/erc721-puppet/tables/Owners.sol";
import { TokenURI } from "@latticexyz/world-modules/src/modules/erc721-puppet/tables/TokenURI.sol";

import { _tokenUriTableId } from "@latticexyz/world-modules/src/modules/erc721-puppet/utils.sol";
import { _ownersTableId } from "@latticexyz/world-modules/src/modules/erc721-puppet/utils.sol";

import { ERC721Config } from "../codegen/index.sol";

type ERC721Namespace is bytes14;

using LibERC721 for ERC721Namespace global;

library LibERC721 {
  error LibERC721_MustBeTokenOwner();

  function unwrap(ERC721Namespace namespace) internal pure returns (bytes14) {
    return ERC721Namespace.unwrap(namespace);
  }

  function tokenAddress(ERC721Namespace namespace) internal view returns (address) {
    return ERC721Config.get(namespace.unwrap());
  }

  function tokenURI(ERC721Namespace namespace, uint256 tokenId) internal view returns (string memory) {
    string memory uri = TokenURI.get(_tokenUriTableId(namespace.unwrap()), tokenId);
    return uri;
  }

  function ownerOf(ERC721Namespace namespace, uint256 tokenId) internal view returns (address) {
    address addr = Owners.get(_ownersTableId(namespace.unwrap()), tokenId);
    return addr;
  }

  function requireOwner(ERC721Namespace namespace, address account, uint256 tokenId) internal view {
    if (account != namespace.ownerOf(tokenId)) {
      revert LibERC721_MustBeTokenOwner();
    }
  }
}
