// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { IERC721Mintable } from "@latticexyz/world-modules/src/modules/erc721-puppet/IERC721Mintable.sol";
import { IERC721 } from "@latticexyz/world-modules/src/modules/erc721-puppet/IERC721.sol";

import { WorldContextConsumerLib } from "@latticexyz/world/src/WorldContext.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { Puppet } from "@latticexyz/world-modules/src/modules/puppet/Puppet.sol";
import { Owners } from "@latticexyz/world-modules/src/modules/erc721-puppet/tables/Owners.sol";
import { TokenURI } from "@latticexyz/world-modules/src/modules/erc721-puppet/tables/TokenURI.sol";
import { IBaseWorld } from "@latticexyz/world/src/codegen/interfaces/IBaseWorld.sol";

import { _tokenUriTableId } from "@latticexyz/world-modules/src/modules/erc721-puppet/utils.sol";

import { GameConfig } from "../codegen/index.sol";

library LibToken {
  error LibToken_MustBeTokenOwner();

  function tokenURI(uint256 tokenId) internal view returns (string memory) {
    bytes14 namespace = GameConfig.getTokenNamespace();

    string memory uri = TokenURI.get(_tokenUriTableId(namespace), tokenId);
    return uri;
  }

  function mint(address tokenAddress, address to, uint256 tokenId) internal {
    IERC721Mintable erc721 = IERC721Mintable(tokenAddress);
    erc721.mint(to, tokenId);
  }

  function burn(address tokenAddress, uint256 tokenId) internal {
    IERC721Mintable erc721 = IERC721Mintable(tokenAddress);
    erc721.burn(tokenId);
  }

  function transferToken(address _to, uint256 _value) internal {
    address token = GameConfig.getTokenAddress();
    address owner = GameConfig.getOwner();
    ResourceId systemId = Puppet(token).systemId();

    bytes memory callData = abi.encodeCall(IERC721.transferFrom, (owner, _to, _value));

    address worldAddress = WorldContextConsumerLib._world();
    (bool success, ) = worldAddress.delegatecall(abi.encodeCall(IBaseWorld(worldAddress).call, (systemId, callData)));

    require(success, "token transfer failed");
  }

  function ownerOf() internal view returns (address owner) {
    owner = GameConfig.getOwner();
  }

  function requireOwner(address account) internal view {
    if (account != ownerOf()) {
      revert LibToken_MustBeTokenOwner();
    }
  }
}
