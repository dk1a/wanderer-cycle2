import { EntityIndex } from "@latticexyz/recs";
import { useWandererContext } from "../../contexts/WandererContext";

export default function Wanderer({
  wandererEntity,
}: {
  wandererEntity: EntityIndex;
}) {
  const { selectedWandererEntity, selectWandererEntity } = useWandererContext();

  return (
    <div className="">
      <div className="">
        {wandererEntity === selectedWandererEntity && (
          <button disabled={true}>
            <span className="">Selected</span>
          </button>
        )}
        {wandererEntity !== selectedWandererEntity && (
          <button
            style={{ width: "6rem" }}
            onClick={() => selectWandererEntity(wandererEntity)}
          >
            Select
          </button>
        )}
      </div>
    </div>
  );
}
