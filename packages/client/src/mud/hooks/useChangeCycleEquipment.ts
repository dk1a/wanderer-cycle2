// import { Entity } from "@latticexyz/recs";
// import { useCallback } from "react";
// import { useWandererContext } from "../../contexts/WandererContext";
// import {useMUD} from "../../MUDContext";
//
// export enum EquipmentAction {
//   UNEQUIP,
//   EQUIP,
// }
//
// export const useChangeCycleEquipment = () => {
//   const { systemCalls } = useMUD();
//   const { selectedWandererEntity } = useWandererContext();
//
//   return useCallback(
//     async (action: EquipmentAction, equipmentSlot: Entity, equipmentEntity: Entity) => {
//       if (!selectedWandererEntity) {
//         throw new Error("No wanderer entity is selected");
//       }
//       const selectedWandererEntityId = world.entities[selectedWandererEntity];
//       const equipmentSlotId = world.entities[equipmentSlot];
//       const equipmentEntityId = world.entities[equipmentEntity];
//       const tx = await systemCalls.сycleEquipment(
//         action,
//         selectedWandererEntityId,
//         equipmentSlotId,
//         equipmentEntityId
//       );
//       await tx.wait();
//     },
//     [systemCalls, selectedWandererEntity]
//   );
// };
