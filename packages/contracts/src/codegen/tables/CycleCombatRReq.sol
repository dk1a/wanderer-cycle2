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

struct CycleCombatRReqData {
  bytes32 mapEntity;
  uint32 connection;
  uint32 fortune;
  uint32[3] winnerPStat;
  uint32[3] loserPStat;
}

library CycleCombatRReq {
  // Hex below is the result of `WorldResourceIdLib.encode({ namespace: "", name: "CycleCombatRReq", typeId: RESOURCE_TABLE });`
  ResourceId constant _tableId = ResourceId.wrap(0x746200000000000000000000000000004379636c65436f6d6261745252657100);

  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x0028030220040400000000000000000000000000000000000000000000000000);

  // Hex-encoded key schema of (bytes32)
  Schema constant _keySchema = Schema.wrap(0x002001005f000000000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (bytes32, uint32, uint32, uint32[], uint32[])
  Schema constant _valueSchema = Schema.wrap(0x002803025f030365650000000000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](1);
    keyNames[0] = "requestId";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](5);
    fieldNames[0] = "mapEntity";
    fieldNames[1] = "connection";
    fieldNames[2] = "fortune";
    fieldNames[3] = "winnerPStat";
    fieldNames[4] = "loserPStat";
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
   * @notice Get mapEntity.
   */
  function getMapEntity(bytes32 requestId) internal view returns (bytes32 mapEntity) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (bytes32(_blob));
  }

  /**
   * @notice Get mapEntity.
   */
  function _getMapEntity(bytes32 requestId) internal view returns (bytes32 mapEntity) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (bytes32(_blob));
  }

  /**
   * @notice Set mapEntity.
   */
  function setMapEntity(bytes32 requestId, bytes32 mapEntity) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((mapEntity)), _fieldLayout);
  }

  /**
   * @notice Set mapEntity.
   */
  function _setMapEntity(bytes32 requestId, bytes32 mapEntity) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((mapEntity)), _fieldLayout);
  }

  /**
   * @notice Get connection.
   */
  function getConnection(bytes32 requestId) internal view returns (uint32 connection) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint32(bytes4(_blob)));
  }

  /**
   * @notice Get connection.
   */
  function _getConnection(bytes32 requestId) internal view returns (uint32 connection) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint32(bytes4(_blob)));
  }

  /**
   * @notice Set connection.
   */
  function setConnection(bytes32 requestId, uint32 connection) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((connection)), _fieldLayout);
  }

  /**
   * @notice Set connection.
   */
  function _setConnection(bytes32 requestId, uint32 connection) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    StoreCore.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((connection)), _fieldLayout);
  }

  /**
   * @notice Get fortune.
   */
  function getFortune(bytes32 requestId) internal view returns (uint32 fortune) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (uint32(bytes4(_blob)));
  }

  /**
   * @notice Get fortune.
   */
  function _getFortune(bytes32 requestId) internal view returns (uint32 fortune) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (uint32(bytes4(_blob)));
  }

  /**
   * @notice Set fortune.
   */
  function setFortune(bytes32 requestId, uint32 fortune) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((fortune)), _fieldLayout);
  }

  /**
   * @notice Set fortune.
   */
  function _setFortune(bytes32 requestId, uint32 fortune) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    StoreCore.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((fortune)), _fieldLayout);
  }

  /**
   * @notice Get winnerPStat.
   */
  function getWinnerPStat(bytes32 requestId) internal view returns (uint32[3] memory winnerPStat) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return toStaticArray_uint32_3(SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint32());
  }

  /**
   * @notice Get winnerPStat.
   */
  function _getWinnerPStat(bytes32 requestId) internal view returns (uint32[3] memory winnerPStat) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return toStaticArray_uint32_3(SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint32());
  }

  /**
   * @notice Set winnerPStat.
   */
  function setWinnerPStat(bytes32 requestId, uint32[3] memory winnerPStat) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode(fromStaticArray_uint32_3(winnerPStat)));
  }

  /**
   * @notice Set winnerPStat.
   */
  function _setWinnerPStat(bytes32 requestId, uint32[3] memory winnerPStat) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode(fromStaticArray_uint32_3(winnerPStat)));
  }

  // The length of winnerPStat
  uint256 constant lengthWinnerPStat = 3;

  /**
   * @notice Get an item of winnerPStat.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemWinnerPStat(bytes32 requestId, uint256 _index) internal view returns (uint32) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    uint256 dynamicLength = _byteLength / 4;
    uint256 staticLength = 3;

    if (_index < staticLength && _index >= dynamicLength) {
      return (uint32(bytes4(new bytes(0))));
    }

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 4, (_index + 1) * 4);
      return (uint32(bytes4(_blob)));
    }
  }

  /**
   * @notice Get an item of winnerPStat.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemWinnerPStat(bytes32 requestId, uint256 _index) internal view returns (uint32) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    uint256 dynamicLength = _byteLength / 4;
    uint256 staticLength = 3;

    if (_index < staticLength && _index >= dynamicLength) {
      return (uint32(bytes4(new bytes(0))));
    }

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 4, (_index + 1) * 4);
      return (uint32(bytes4(_blob)));
    }
  }

  /**
   * @notice Update an element of winnerPStat at `_index`.
   */
  function updateWinnerPStat(bytes32 requestId, uint256 _index, uint32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 4), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of winnerPStat at `_index`.
   */
  function _updateWinnerPStat(bytes32 requestId, uint256 _index, uint32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 4), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Get loserPStat.
   */
  function getLoserPStat(bytes32 requestId) internal view returns (uint32[3] memory loserPStat) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 1);
    return toStaticArray_uint32_3(SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint32());
  }

  /**
   * @notice Get loserPStat.
   */
  function _getLoserPStat(bytes32 requestId) internal view returns (uint32[3] memory loserPStat) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 1);
    return toStaticArray_uint32_3(SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint32());
  }

  /**
   * @notice Set loserPStat.
   */
  function setLoserPStat(bytes32 requestId, uint32[3] memory loserPStat) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 1, EncodeArray.encode(fromStaticArray_uint32_3(loserPStat)));
  }

  /**
   * @notice Set loserPStat.
   */
  function _setLoserPStat(bytes32 requestId, uint32[3] memory loserPStat) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    StoreCore.setDynamicField(_tableId, _keyTuple, 1, EncodeArray.encode(fromStaticArray_uint32_3(loserPStat)));
  }

  // The length of loserPStat
  uint256 constant lengthLoserPStat = 3;

  /**
   * @notice Get an item of loserPStat.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemLoserPStat(bytes32 requestId, uint256 _index) internal view returns (uint32) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 1);
    uint256 dynamicLength = _byteLength / 4;
    uint256 staticLength = 3;

    if (_index < staticLength && _index >= dynamicLength) {
      return (uint32(bytes4(new bytes(0))));
    }

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 1, _index * 4, (_index + 1) * 4);
      return (uint32(bytes4(_blob)));
    }
  }

  /**
   * @notice Get an item of loserPStat.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemLoserPStat(bytes32 requestId, uint256 _index) internal view returns (uint32) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 1);
    uint256 dynamicLength = _byteLength / 4;
    uint256 staticLength = 3;

    if (_index < staticLength && _index >= dynamicLength) {
      return (uint32(bytes4(new bytes(0))));
    }

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 1, _index * 4, (_index + 1) * 4);
      return (uint32(bytes4(_blob)));
    }
  }

  /**
   * @notice Update an element of loserPStat at `_index`.
   */
  function updateLoserPStat(bytes32 requestId, uint256 _index, uint32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 1, uint40(_index * 4), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of loserPStat at `_index`.
   */
  function _updateLoserPStat(bytes32 requestId, uint256 _index, uint32 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 1, uint40(_index * 4), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Get the full data.
   */
  function get(bytes32 requestId) internal view returns (CycleCombatRReqData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    (bytes memory _staticData, EncodedLengths _encodedLengths, bytes memory _dynamicData) = StoreSwitch.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Get the full data.
   */
  function _get(bytes32 requestId) internal view returns (CycleCombatRReqData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    (bytes memory _staticData, EncodedLengths _encodedLengths, bytes memory _dynamicData) = StoreCore.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function set(
    bytes32 requestId,
    bytes32 mapEntity,
    uint32 connection,
    uint32 fortune,
    uint32[3] memory winnerPStat,
    uint32[3] memory loserPStat
  ) internal {
    bytes memory _staticData = encodeStatic(mapEntity, connection, fortune);

    EncodedLengths _encodedLengths = encodeLengths(winnerPStat, loserPStat);
    bytes memory _dynamicData = encodeDynamic(winnerPStat, loserPStat);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function _set(
    bytes32 requestId,
    bytes32 mapEntity,
    uint32 connection,
    uint32 fortune,
    uint32[3] memory winnerPStat,
    uint32[3] memory loserPStat
  ) internal {
    bytes memory _staticData = encodeStatic(mapEntity, connection, fortune);

    EncodedLengths _encodedLengths = encodeLengths(winnerPStat, loserPStat);
    bytes memory _dynamicData = encodeDynamic(winnerPStat, loserPStat);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function set(bytes32 requestId, CycleCombatRReqData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.mapEntity, _table.connection, _table.fortune);

    EncodedLengths _encodedLengths = encodeLengths(_table.winnerPStat, _table.loserPStat);
    bytes memory _dynamicData = encodeDynamic(_table.winnerPStat, _table.loserPStat);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function _set(bytes32 requestId, CycleCombatRReqData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.mapEntity, _table.connection, _table.fortune);

    EncodedLengths _encodedLengths = encodeLengths(_table.winnerPStat, _table.loserPStat);
    bytes memory _dynamicData = encodeDynamic(_table.winnerPStat, _table.loserPStat);

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Decode the tightly packed blob of static data using this table's field layout.
   */
  function decodeStatic(
    bytes memory _blob
  ) internal pure returns (bytes32 mapEntity, uint32 connection, uint32 fortune) {
    mapEntity = (Bytes.getBytes32(_blob, 0));

    connection = (uint32(Bytes.getBytes4(_blob, 32)));

    fortune = (uint32(Bytes.getBytes4(_blob, 36)));
  }

  /**
   * @notice Decode the tightly packed blob of dynamic data using the encoded lengths.
   */
  function decodeDynamic(
    EncodedLengths _encodedLengths,
    bytes memory _blob
  ) internal pure returns (uint32[3] memory winnerPStat, uint32[3] memory loserPStat) {
    uint256 _start;
    uint256 _end;
    unchecked {
      _end = _encodedLengths.atIndex(0);
    }
    winnerPStat = toStaticArray_uint32_3(SliceLib.getSubslice(_blob, _start, _end).decodeArray_uint32());

    _start = _end;
    unchecked {
      _end += _encodedLengths.atIndex(1);
    }
    loserPStat = toStaticArray_uint32_3(SliceLib.getSubslice(_blob, _start, _end).decodeArray_uint32());
  }

  /**
   * @notice Decode the tightly packed blobs using this table's field layout.
   * @param _staticData Tightly packed static fields.
   * @param _encodedLengths Encoded lengths of dynamic fields.
   * @param _dynamicData Tightly packed dynamic fields.
   */
  function decode(
    bytes memory _staticData,
    EncodedLengths _encodedLengths,
    bytes memory _dynamicData
  ) internal pure returns (CycleCombatRReqData memory _table) {
    (_table.mapEntity, _table.connection, _table.fortune) = decodeStatic(_staticData);

    (_table.winnerPStat, _table.loserPStat) = decodeDynamic(_encodedLengths, _dynamicData);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(bytes32 requestId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(bytes32 requestId) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(bytes32 mapEntity, uint32 connection, uint32 fortune) internal pure returns (bytes memory) {
    return abi.encodePacked(mapEntity, connection, fortune);
  }

  /**
   * @notice Tightly pack dynamic data lengths using this table's schema.
   * @return _encodedLengths The lengths of the dynamic fields (packed into a single bytes32 value).
   */
  function encodeLengths(
    uint32[3] memory winnerPStat,
    uint32[3] memory loserPStat
  ) internal pure returns (EncodedLengths _encodedLengths) {
    // Lengths are effectively checked during copy by 2**40 bytes exceeding gas limits
    unchecked {
      _encodedLengths = EncodedLengthsLib.pack(winnerPStat.length * 4, loserPStat.length * 4);
    }
  }

  /**
   * @notice Tightly pack dynamic (variable length) data using this table's schema.
   * @return The dynamic data, encoded into a sequence of bytes.
   */
  function encodeDynamic(
    uint32[3] memory winnerPStat,
    uint32[3] memory loserPStat
  ) internal pure returns (bytes memory) {
    return
      abi.encodePacked(
        EncodeArray.encode(fromStaticArray_uint32_3(winnerPStat)),
        EncodeArray.encode(fromStaticArray_uint32_3(loserPStat))
      );
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(
    bytes32 mapEntity,
    uint32 connection,
    uint32 fortune,
    uint32[3] memory winnerPStat,
    uint32[3] memory loserPStat
  ) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData = encodeStatic(mapEntity, connection, fortune);

    EncodedLengths _encodedLengths = encodeLengths(winnerPStat, loserPStat);
    bytes memory _dynamicData = encodeDynamic(winnerPStat, loserPStat);

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(bytes32 requestId) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = requestId;

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