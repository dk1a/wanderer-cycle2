import { useGuises } from "../../mud/hooks/guise";
// import { useWandererSpawn } from "../../mud/hooks/useWandererSpawn";
// import Guise from "../Guise/Guise";

export default function WandererSpawn() {
  const guises = useGuises();

  return (
    <div>
      {guises.map((guise) => (
        <div
          className="flex justify-center items-center flex-col"
          key={guise.entity}
        ></div>
      ))}
    </div>
  );
}
