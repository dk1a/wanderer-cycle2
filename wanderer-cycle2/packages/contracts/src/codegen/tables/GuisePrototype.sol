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

ResourceId constant _tableId = ResourceId.wrap(
  bytes32(abi.encodePacked(RESOURCE_TABLE, bytes14(""), bytes16("GuisePrototype")))
);
ResourceId constant GuisePrototypeTableId = _tableId;

FieldLayout constant _fieldLayout = FieldLayout.wrap(
  0x0000000100000000000000000000000000000000000000000000000000000000
);

library GuisePrototype {
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
    SchemaType[] memory _keySchema = new SchemaType[](1);
    _keySchema[0] = SchemaType.BYTES32;

    return SchemaLib.encode(_keySchema);
  }

  /**
   * @notice Get the table's value schema.
   * @return _valueSchema The value schema for the table.
   */
  function getValueSchema() internal pure returns (Schema) {
    SchemaType[] memory _valueSchema = new SchemaType[](1);
    _valueSchema[0] = SchemaType.UINT32_ARRAY;

    return SchemaLib.encode(_valueSchema);
  }

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](1);
    keyNames[0] = "entity";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](1);
    fieldNames[0] = "value";
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
   * @notice Get value.
   */
  function getValue(bytes32 entity) internal view returns (uint32[3] memory value) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return toStaticArray_uint32_3(SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint32());
  }

  /**
   * @notice Get value.
   */
  function _getValue(bytes32 entity) internal view returns (uint32[3] memory value) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return toStaticArray_uint32_3(SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint32());
  }

  /**
   * @notice Get value.
   */
  function get(bytes32 entity) internal view returns (uint32[3] memory value) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return toStaticArray_uint32_3(SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint32());
  }

  /**
   * @notice Get value.
   */
  function _get(bytes32 entity) internal view returns (uint32[3] memory value) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return toStaticArray_uint32_3(SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint32());
  }

  /**
   * @notice Set value.
   */
  function setValue(bytes32 entity, uint32[3] memory value) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode(fromStaticArray_uint32_3(value)));
  }

  /**
   * @notice Set value.
   */
  function _setValue(bytes32 entity, uint32[3] memory value) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode(fromStaticArray_uint32_3(value)));
  }

  /**
   * @notice Set value.
   */
  function set(bytes32 entity, uint32[3] memory value) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode(fromStaticArray_uint32_3(value)));
  }

  /**
   * @notice Set value.
   */
  function _set(bytes32 entity, uint32[3] memory value) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode(fromStaticArray_uint32_3(value)));
  }

  /**
   * @notice Get the length of value.
   */
  function lengthValue(bytes32 entity) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 4;
    }
  }

  /**
   * @notice Get the length of value.
   */
  function _lengthValue(bytes32 entity) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 4;
    }
  }

  /**
   * @notice Get the length of value.
   */
  function length(bytes32 entity) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 4;
    }
  }

  /**
   * @notice Get the length of value.
   */
  function _length(bytes32 entity) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    unchecked {
      return _byteLength / 4;
    }
  }

  /**
   * @notice Get an item of value.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemValue(bytes32 entity, uint256 _index) internal view returns (uint32) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 4, (_index + 1) * 4);
      return (uint32(bytes4(_blob)));
    }
  }

  /**
   * @notice Get an item of value.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemValue(bytes32 entity, uint256 _index) internal view returns (uint32) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 4, (_index + 1) * 4);
      return (uint32(bytes4(_blob)));
    }
  }

  /**
   * @notice Get an item of value.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItem(bytes32 entity, uint256 _index) internal view returns (uint32) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 4, (_index + 1) * 4);
      return (uint32(bytes4(_blob)));
    }
  }

  /**
   * @notice Get an item of value.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItem(bytes32 entity, uint256 _index) internal view returns (uint32) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 4, (_index + 1) * 4);
      return (uint32(bytes4(_blob)));
    }
  }

  /**
   * @notice Push an element to value.
   */
  function pushValue(bytes32 entity, uint32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to value.
   */
  function _pushValue(bytes32 entity, uint32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to value.
   */
  function push(bytes32 entity, uint32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    StoreSwitch.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Push an element to value.
   */
  function _push(bytes32 entity, uint32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    StoreCore.pushToDynamicField(_tableId, _keyTuple, 0, abi.encodePacked((_element)));
  }

  /**
   * @notice Pop an element from value.
   */
  function popValue(bytes32 entity) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 4);
  }

  /**
   * @notice Pop an element from value.
   */
  function _popValue(bytes32 entity) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 4);
  }

  /**
   * @notice Pop an element from value.
   */
  function pop(bytes32 entity) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    StoreSwitch.popFromDynamicField(_tableId, _keyTuple, 0, 4);
  }

  /**
   * @notice Pop an element from value.
   */
  function _pop(bytes32 entity) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    StoreCore.popFromDynamicField(_tableId, _keyTuple, 0, 4);
  }

  /**
   * @notice Update an element of value at `_index`.
   */
  function updateValue(bytes32 entity, uint256 _index, uint32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 4), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of value at `_index`.
   */
  function _updateValue(bytes32 entity, uint256 _index, uint32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 4), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of value at `_index`.
   */
  function update(bytes32 entity, uint256 _index, uint32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 4), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of value at `_index`.
   */
  function _update(bytes32 entity, uint256 _index, uint32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 4), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(bytes32 entity) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(bytes32 entity) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack dynamic data lengths using this table's schema.
   * @return _encodedLengths The lengths of the dynamic fields (packed into a single bytes32 value).
   */
  function encodeLengths(uint32[3] memory value) internal pure returns (PackedCounter _encodedLengths) {
    // Lengths are effectively checked during copy by 2**40 bytes exceeding gas limits
    unchecked {
      _encodedLengths = PackedCounterLib.pack(value.length * 4);
    }
  }

  /**
   * @notice Tightly pack dynamic (variable length) data using this table's schema.
   * @return The dynamic data, encoded into a sequence of bytes.
   */
  function encodeDynamic(uint32[3] memory value) internal pure returns (bytes memory) {
    return abi.encodePacked(EncodeArray.encode(fromStaticArray_uint32_3(value)));
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dyanmic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(uint32[3] memory value) internal pure returns (bytes memory, PackedCounter, bytes memory) {
    bytes memory _staticData;
    PackedCounter _encodedLengths = encodeLengths(value);
    bytes memory _dynamicData = encodeDynamic(value);

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(bytes32 entity) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = entity;

    return _keyTuple;
  }
}

/**
 * @notice Cast a dynamic array to a static array.
 * @dev In memory static arrays are just dynamic arrays without the 32 length bytes,
 * so this function moves the pointer to the first element of the dynamic array.
 * If the length of the dynamic array is smaller than the static length,
 * the function returns an uninitialized array to avoid memory corruption.
 * @param _value The dynamic array to cast.
 * @return _result The static array.
 */
function toStaticArray_uint32_3(uint32[] memory _value) pure returns (uint32[3] memory _result) {
  if (_value.length < 3) {
    // return an uninitialized array if the length is smaller than the fixed length to avoid memory corruption
    return _result;
  } else {
    // in memory static arrays are just dynamic arrays without the 32 length bytes
    // (without the length check this could lead to memory corruption)
    assembly {
      _result := add(_value, 0x20)
    }
  }
}

/**
 * @notice Copy a static array to a dynamic array.
 * @dev Static arrays don't have a length prefix, so this function copies the memory from the static array to a new dynamic array.
 * @param _value The static array to copy.
 * @return _result The dynamic array.
 */
function fromStaticArray_uint32_3(uint32[3] memory _value) pure returns (uint32[] memory _result) {
  _result = new uint32[](3);
  uint256 fromPointer;
  uint256 toPointer;
  assembly {
    fromPointer := _value
    toPointer := add(_result, 0x20)
  }
  Memory.copy(fromPointer, toPointer, 96);
}
