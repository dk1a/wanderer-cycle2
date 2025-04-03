import { Entity } from "@latticexyz/recs";

export const MAX_ROUNDS = 12;

export interface CombatAction {
  actionType: ActionType;
  actionEntity: Entity;
}

export enum ActionType {
  ATTACK,
  SKILL,
}

export const attackAction: CombatAction = {
  actionType: ActionType.ATTACK,
  actionEntity: "0x00" as Entity,
};
