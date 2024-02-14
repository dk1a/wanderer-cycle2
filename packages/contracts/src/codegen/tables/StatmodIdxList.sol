// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

/* Autogenerated file. Do not edit manually. */

// Import schema type
import { SchemaType } from "@latticexyz/schema-type/src/solidity/SchemaType.sol";

// Import store internals
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { StoreCore } from "@latticexyz/store/src/StoreCore.sol";
import { Bytes } from "@latticexyz/store/src/Bytes.sol";
import { Memory } from "@latticexyz/store/src/Memory.sol";
import { SliceLib } from "@latticexyz/store/src/Slice.sol";
import { EncodeArray } from "@latticexyz/store/src/tightcoder/EncodeArray.sol";
import { FieldLayout, FieldLayoutLib } from "@latticexyz/store/src/FieldLayout.sol";
import { Schema, SchemaLib } from "@latticexyz/store/src/Schema.sol";
import { PackedCounter, PackedCounterLib } from "@latticexyz/store/src/PackedCounter.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { RESOURCE_TABLE, RESOURCE_OFFCHAIN_TABLE } from "@latticexyz/store/src/storeResourceTypes.sol";

// Import user types
import { StatmodTopic } from "./../../statmod/StatmodTopic.sol";

ResourceId constant _tableId = ResourceId.wrap(
  bytes32(abi.encodePacked(RESOURCE_TABLE, bytes14(""), bytes16("StatmodIdxList")))
);
ResourceId constant StatmodIdxListTableId = _tableId;

FieldLayout constant _fieldLayout = FieldLayout.wrap(
  0x0000000100000000000000000000000000000000000000000000000000000000
);

library StatmodIdxList {
  /**
   * @notice Get the table values' field layout.
   * @return _fieldLayout The field layout for the table.
   */
  function getFieldLayout() internal pure returns (FieldLayout) {
    return _fieldLayout;
  }

  /**
   * @notice Get the table's key schema.
   * @return _keySchema The key schema for the table.
   */
  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _keySchema = new SchemaType[](2);
    _keySchema[0] = SchemaType.BYTES32;
    _keySchema[1] = SchemaType.BYTES32;

    return SchemaLib.encode(_keySchema);
  }

  /**
   * @notice Get the table's value schema.
   * @return _valueSchema The value schema for the table.
   */
  function getValueSchema() internal pure returns (Schema) {
    SchemaType[] memory _valueSchema = new SchemaType[](1);
    _valueSchema[0] = SchemaType.BYTES32_ARRAY;

    return SchemaLib.encode(_valueSchema);
  }

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](2);
    keyNames[0] = "targetEntity";
    keyNames[1] = "statmodTopic";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](1);
    fieldNames[0] = "baseEntities";
  }

  /**
   * @notice Register the table with its config.
   */
  function register() internal {
    StoreSwitch.registerTable(_tableId, _fieldLayout, getKeySchema(), getValueSchema(), getKeyNames(), getFieldNames());
  }

  /**
   * @notice Register the table with its config.
   */
  function _register() internal {
    StoreCore.registerTable(_tableId, _fieldLayout, getKeySchema(), getValueSchema(), getKeyNames(), getFieldNames());
  }

  /**
   * @notice Get baseEntities.
   */
  function getBaseEntities(
    bytes32 targetEntity,
    StatmodTopic statmodTopic
  ) internal view returns (bytes32[] memory baseEntities) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes32());
  }

  /**
   * @notice Get baseEntities.
   */
  function _getBaseEntities(
    bytes32 targetEntity,
    StatmodTopic statmodTopic
  ) internal view returns (bytes32[] memory baseEntities) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes32());
  }

  /**
   * @notice Get baseEntities.
   */
  function get(bytes32 targetEntity, StatmodTopic statmodTopic) internal view returns (bytes32[] memory baseEntities) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes32());
  }

  /**
   * @notice Get baseEntities.
   */
  function _get(bytes32 targetEntity, StatmodTopic statmodTopic) internal view returns (bytes32[] memory baseEntities) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return (SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_bytes32());
  }

  /**
   * @notice Set baseEntities.
   */
  function setBaseEntities(bytes32 targetEntity, StatmodTopic statmodTopic, bytes32[] memory baseEntities) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((baseEntities)));
  }

  /**
   * @notice Set baseEntities.
   */
  function _setBaseEntities(bytes32 targetEntity, StatmodTopic statmodTopic, bytes32[] memory baseEntities) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((baseEntities)));
  }

  /**
   * @notice Set baseEntities.
   */
  function set(bytes32 targetEntity, StatmodTopic statmodTopic, bytes32[] memory baseEntities) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((baseEntities)));
  }

  /**
   * @notice Set baseEntities.
   */
  function _set(bytes32 targetEntity, StatmodTopic statmodTopic, bytes32[] memory baseEntities) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode((baseEntities)));
  }

  /**
   * @notice Get the length of baseEntities.
   */
  function lengthBaseEntities(bytes32 targetEntity, StatmodTopic statmodTopic) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 32;
    }
  }

  /**
   * @notice Get the length of baseEntities.
   */
  function _lengthBaseEntities(bytes32 targetEntity, StatmodTopic statmodTopic) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 32;
    }
  }

  /**
   * @notice Get the length of baseEntities.
   */
  function length(bytes32 targetEntity, StatmodTopic statmodTopic) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 32;
    }
  }

  /**
   * @notice Get the length of baseEntities.
   */
  function _length(bytes32 targetEntity, StatmodTopic statmodTopic) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 32;
    }
  }

  /**
   * @notice Get an item of baseEntities.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemBaseEntities(
    bytes32 targetEntity,
    StatmodTopic statmodTopic,
    uint256 _index
  ) internal view returns (bytes32) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 32, (_index + 1) * 32);
      return (bytes32(_blob));
    }
  }

  /**
   * @notice Get an item of baseEntities.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemBaseEntities(
    bytes32 targetEntity,
    StatmodTopic statmodTopic,
    uint256 _index
  ) internal view returns (bytes32) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 32, (_index + 1) * 32);
      return (bytes32(_blob));
    }
  }

  /**
   * @notice Get an item of baseEntities.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItem(bytes32 targetEntity, StatmodTopic statmodTopic, uint256 _index) internal view returns (bytes32) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 32, (_index + 1) * 32);
      return (bytes32(_blob));
    }
  }

  /**
   * @notice Get an item of baseEntities.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItem(bytes32 targetEntity, StatmodTopic statmodTopic, uint256 _index) internal view returns (bytes32) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 32, (_index + 1) * 32);
      return (bytes32(_blob));
    }
  }

  /**
   * @notice Push an element to baseEntities.
   */
  function pushBaseEntities(bytes32 targetEntity, StatmodTopic statmodTopic, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to baseEntities.
   */
  function _pushBaseEntities(bytes32 targetEntity, StatmodTopic statmodTopic, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to baseEntities.
   */
  function push(bytes32 targetEntity, StatmodTopic statmodTopic, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to baseEntities.
   */
  function _push(bytes32 targetEntity, StatmodTopic statmodTopic, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Pop an element from baseEntities.
   */
  function popBaseEntities(bytes32 targetEntity, StatmodTopic statmodTopic) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 32);
  }

  /**
   * @notice Pop an element from baseEntities.
   */
  function _popBaseEntities(bytes32 targetEntity, StatmodTopic statmodTopic) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 32);
  }

  /**
   * @notice Pop an element from baseEntities.
   */
  function pop(bytes32 targetEntity, StatmodTopic statmodTopic) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 32);
  }

  /**
   * @notice Pop an element from baseEntities.
   */
  function _pop(bytes32 targetEntity, StatmodTopic statmodTopic) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 32);
  }

  /**
   * @notice Update an element of baseEntities at `_index`.
   */
  function updateBaseEntities(
    bytes32 targetEntity,
    StatmodTopic statmodTopic,
    uint256 _index,
    bytes32 _element
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 32), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of baseEntities at `_index`.
   */
  function _updateBaseEntities(
    bytes32 targetEntity,
    StatmodTopic statmodTopic,
    uint256 _index,
    bytes32 _element
  ) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 32), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of baseEntities at `_index`.
   */
  function update(bytes32 targetEntity, StatmodTopic statmodTopic, uint256 _index, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 32), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of baseEntities at `_index`.
   */
  function _update(bytes32 targetEntity, StatmodTopic statmodTopic, uint256 _index, bytes32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 32), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(bytes32 targetEntity, StatmodTopic statmodTopic) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(bytes32 targetEntity, StatmodTopic statmodTopic) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack dynamic data lengths using this table's schema.
   * @return _encodedLengths The lengths of the dynamic fields (packed into a single bytes32 value).
   */
  function encodeLengths(bytes32[] memory baseEntities) internal pure returns (PackedCounter _encodedLengths) {
    // Lengths are effectively checked during copy by 2**40 bytes exceeding gas limits
    unchecked {
      _encodedLengths = PackedCounterLib.pack(baseEntities.length * 32);
    }
  }

  /**
   * @notice Tightly pack dynamic (variable length) data using this table's schema.
   * @return The dynamic data, encoded into a sequence of bytes.
   */
  function encodeDynamic(bytes32[] memory baseEntities) internal pure returns (bytes memory) {
    return abi.encodePacked(EncodeArray.encode((baseEntities)));
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(bytes32[] memory baseEntities) internal pure returns (bytes memory, PackedCounter, bytes memory) {
    bytes memory _staticData;
    PackedCounter _encodedLengths = encodeLengths(baseEntities);
    bytes memory _dynamicData = encodeDynamic(baseEntities);

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(bytes32 targetEntity, StatmodTopic statmodTopic) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = targetEntity;
    _keyTuple[1] = StatmodTopic.unwrap(statmodTopic);

    return _keyTuple;
  }
}
