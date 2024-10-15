import { useGuises } from "../../mud/hooks/guise";
import Guise from "../Guise/Guise";
import React from "react";
import { useWandererSpawn } from "../../mud/hooks/useWandererSpawn";

export default function WandererSpawn({ disabled }: { disabled: boolean }) {
  const guises = useGuises();
  const wandererSpawn = useWandererSpawn();

  return (
    <div>
      {guises.map((guise) => (
        <Guise
          key={guise.entity}
          guise={guise}
          disabled={disabled}
          onSelectGuise={wandererSpawn}
        />
      ))}
    </div>
  );
}
