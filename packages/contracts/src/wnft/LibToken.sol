// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { ERC721System } from "@latticexyz/world-modules/src/modules/erc721-puppet/ERC721System.sol";
import { IERC721Metadata } from "@latticexyz/world-modules/src/modules/erc721-puppet/IERC721Metadata.sol";
import { WNFTOwnership } from "../codegen/index.sol";

struct Token {
  string name;
  string symbol;
}

library LibToken {
  error LibToken_MustBeTokenOwner();

  function tokenOptions(address account) internal view returns (Token memory token) {
    IERC721Metadata erc721 = _takeERC721(account);

    string memory name = erc721.name();
    string memory symbol = erc721.symbol();

    token = Token({ name: name, symbol: symbol });
  }

  function tokenURI(uint256 tokenId, address account) internal view returns (string memory) {
    IERC721Metadata erc721 = _takeERC721(account);
    string memory uri = erc721.tokenURI(tokenId);
    return uri;
  }

  function ownerOf(bytes32 tokenEntity) internal view returns (address) {
    address addr = WNFTOwnership.get(tokenEntity);
    return addr;
  }

  function requireOwner(bytes32 tokenEntity, address account) internal view {
    if (account != ownerOf(tokenEntity)) {
      revert LibToken_MustBeTokenOwner();
    }
  }

  function _takeERC721(address erc721Address) internal pure returns (IERC721Metadata erc721) {
    erc721 = IERC721Metadata(erc721Address);
  }
}
