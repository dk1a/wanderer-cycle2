import { keccak256, toUtf8Bytes } from "ethers";

export interface ScopedDuration {
  timeScopeId: string;
  timeScopeName: string;
  timeValue: number;
}

export const parseScopedDuration = (
  timeScopeId: string,
  timeValue: string,
): ScopedDuration => {
  return {
    timeScopeId,
    timeScopeName: timeScopeIdToName[timeScopeId],
    // Преобразуем строковое значение в bigint, а затем в number
    timeValue: Number(BigInt(timeValue)),
  };
};

// TODO unhardcode this (start with the contracts side)
const timeScopeIdToName = {
  [keccak256(toUtf8Bytes("turn"))]: "turn",
  [keccak256(toUtf8Bytes("round"))]: "round",
  [keccak256(toUtf8Bytes("round_persistent"))]: "round_persistent",
};
