// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

// Import store internals
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { StoreCore } from "@latticexyz/store/src/StoreCore.sol";
import { Bytes } from "@latticexyz/store/src/Bytes.sol";
import { Memory } from "@latticexyz/store/src/Memory.sol";
import { SliceLib } from "@latticexyz/store/src/Slice.sol";
import { EncodeArray } from "@latticexyz/store/src/tightcoder/EncodeArray.sol";
import { FieldLayout } from "@latticexyz/store/src/FieldLayout.sol";
import { Schema } from "@latticexyz/store/src/Schema.sol";
import { EncodedLengths, EncodedLengthsLib } from "@latticexyz/store/src/EncodedLengths.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";

// Import user types
import { AffixPartId } from "../../../../codegen/common.sol";
import { AffixAvailabilityTargetId } from "../../types.sol";

library AffixNaming {
  // Hex below is the result of `WorldResourceIdLib.encode({ namespace: "affix", name: "AffixNaming", typeId: RESOURCE_TABLE });`
  ResourceId constant _tableId = ResourceId.wrap(0x7462616666697800000000000000000041666669784e616d696e670000000000);

  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x0000000100000000000000000000000000000000000000000000000000000000);

  // Hex-encoded key schema of (uint8, bytes32, bytes32)
  Schema constant _keySchema = Schema.wrap(0x00410300005f5f00000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (string)
  Schema constant _valueSchema = Schema.wrap(0x00000001c5000000000000000000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](3);
    keyNames[0] = "affixPart";
    keyNames[1] = "targetId";
    keyNames[2] = "affixPrototypeEntity";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](1);
    fieldNames[0] = "label";
  }

  /**
   * @notice Register the table with its config.
   */
  function register() internal {
    StoreSwitch.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Register the table with its config.
   */
  function _register() internal {
    StoreCore.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Get label.
   */
  function getLabel(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity
  ) internal view returns (string memory label) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return (string(_blob));
  }

  /**
   * @notice Get label.
   */
  function _getLabel(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity
  ) internal view returns (string memory label) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return (string(_blob));
  }

  /**
   * @notice Get label.
   */
  function get(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity
  ) internal view returns (string memory label) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return (string(_blob));
  }

  /**
   * @notice Get label.
   */
  function _get(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity
  ) internal view returns (string memory label) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return (string(_blob));
  }

  /**
   * @notice Set label.
   */
  function setLabel(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity,
    string memory label
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, bytes((label)));
  }

  /**
   * @notice Set label.
   */
  function _setLabel(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity,
    string memory label
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, bytes((label)));
  }

  /**
   * @notice Set label.
   */
  function set(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity,
    string memory label
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, bytes((label)));
  }

  /**
   * @notice Set label.
   */
  function _set(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity,
    string memory label
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, bytes((label)));
  }

  /**
   * @notice Get the length of label.
   */
  function lengthLabel(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity
  ) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of label.
   */
  function _lengthLabel(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity
  ) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of label.
   */
  function length(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity
  ) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get the length of label.
   */
  function _length(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity
  ) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 1;
    }
  }

  /**
   * @notice Get an item of label.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemLabel(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity,
    uint256 _index
  ) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 1, (_index + 1) * 1);
      return (string(_blob));
    }
  }

  /**
   * @notice Get an item of label.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemLabel(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity,
    uint256 _index
  ) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 1, (_index + 1) * 1);
      return (string(_blob));
    }
  }

  /**
   * @notice Get an item of label.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItem(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity,
    uint256 _index
  ) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 1, (_index + 1) * 1);
      return (string(_blob));
    }
  }

  /**
   * @notice Get an item of label.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItem(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity,
    uint256 _index
  ) internal view returns (string memory) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 1, (_index + 1) * 1);
      return (string(_blob));
    }
  }

  /**
   * @notice Push a slice to label.
   */
  function pushLabel(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity,
    string memory _slice
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, bytes((_slice)));
  }

  /**
   * @notice Push a slice to label.
   */
  function _pushLabel(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity,
    string memory _slice
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, bytes((_slice)));
  }

  /**
   * @notice Push a slice to label.
   */
  function push(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity,
    string memory _slice
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, bytes((_slice)));
  }

  /**
   * @notice Push a slice to label.
   */
  function _push(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity,
    string memory _slice
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, bytes((_slice)));
  }

  /**
   * @notice Pop a slice from label.
   */
  function popLabel(AffixPartId affixPart, AffixAvailabilityTargetId targetId, bytes32 affixPrototypeEntity) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 1);
  }

  /**
   * @notice Pop a slice from label.
   */
  function _popLabel(AffixPartId affixPart, AffixAvailabilityTargetId targetId, bytes32 affixPrototypeEntity) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 1);
  }

  /**
   * @notice Pop a slice from label.
   */
  function pop(AffixPartId affixPart, AffixAvailabilityTargetId targetId, bytes32 affixPrototypeEntity) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 1);
  }

  /**
   * @notice Pop a slice from label.
   */
  function _pop(AffixPartId affixPart, AffixAvailabilityTargetId targetId, bytes32 affixPrototypeEntity) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 1);
  }

  /**
   * @notice Update a slice of label at `_index`.
   */
  function updateLabel(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity,
    uint256 _index,
    string memory _slice
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of label at `_index`.
   */
  function _updateLabel(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity,
    uint256 _index,
    string memory _slice
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of label at `_index`.
   */
  function update(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity,
    uint256 _index,
    string memory _slice
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update a slice of label at `_index`.
   */
  function _update(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity,
    uint256 _index,
    string memory _slice
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    unchecked {
      bytes memory _encoded = bytes((_slice));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 1), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack dynamic data lengths using this table's schema.
   * @return _encodedLengths The lengths of the dynamic fields (packed into a single bytes32 value).
   */
  function encodeLengths(string memory label) internal pure returns (EncodedLengths _encodedLengths) {
    // Lengths are effectively checked during copy by 2**40 bytes exceeding gas limits
    unchecked {
      _encodedLengths = EncodedLengthsLib.pack(bytes(label).length);
    }
  }

  /**
   * @notice Tightly pack dynamic (variable length) data using this table's schema.
   * @return The dynamic data, encoded into a sequence of bytes.
   */
  function encodeDynamic(string memory label) internal pure returns (bytes memory) {
    return abi.encodePacked(bytes((label)));
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(string memory label) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData;
    EncodedLengths _encodedLengths = encodeLengths(label);
    bytes memory _dynamicData = encodeDynamic(label);

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(
    AffixPartId affixPart,
    AffixAvailabilityTargetId targetId,
    bytes32 affixPrototypeEntity
  ) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](3);
    _keyTuple[0] = bytes32(uint256(uint8(affixPart)));
    _keyTuple[1] = AffixAvailabilityTargetId.unwrap(targetId);
    _keyTuple[2] = affixPrototypeEntity;

    return _keyTuple;
  }
}
