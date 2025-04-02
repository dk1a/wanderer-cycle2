import { Entity } from "@latticexyz/recs";
import { useNavigate } from "react-router-dom";
import { useWandererContext } from "../../contexts/WandererContext";
import { formatEntity } from "../../mud/utils/format";
import { Button } from "../utils/Button/Button";
import { useEffect } from "react";

interface WandererProps {
  wandererEntity: Entity;
}

export default function Wanderer({ wandererEntity }: WandererProps) {
  const { selectedWandererEntity, selectWandererEntity } = useWandererContext();
  const navigate = useNavigate();

  useEffect(() => {
    try {
      const saved = sessionStorage.getItem("selectedWandererEntity");
      if (saved) {
        selectWandererEntity(saved as Entity);
      }
    } catch (e) {
      console.warn("Error when reading from sessionStorage:", e);
    }
  }, [selectWandererEntity]);

  const handleSelectWanderer = (wanderer: Entity) => {
    try {
      sessionStorage.setItem("selectedWandererEntity", wanderer);
      selectWandererEntity(wanderer);
      navigate("/maps");
    } catch (e) {
      console.warn("ОError when reading from sessionStorage:", e);
    }
  };

  return (
    <div className="border border-dark-400 min-h-[300px] min-w-[200px] h-auto py-2 px-4 flex flex-col justify-between items-center bg-dark-500 transform delay-500">
      <h3 className={"text-dark-type"}>{formatEntity(wandererEntity)}</h3>
      {/*<WandererImage entity={wandererEntity}/>*/}
      <div className="mt-4 flex justify-around w-full">
        {wandererEntity === selectedWandererEntity && (
          <Button disabled={true}>
            <span className="Selected font-medium">Selected</span>
          </Button>
        )}
        {wandererEntity !== selectedWandererEntity && (
          <Button
            className={"w-24"}
            onClick={() => handleSelectWanderer(wandererEntity)}
          >
            Select
          </Button>
        )}
      </div>
    </div>
  );
}
