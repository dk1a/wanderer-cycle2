// import { useSkillStrict } from "../../mud/hooks/skill";

export default function GuiseSkill() {
  // const skill = useSkillStrict(entity);
  return (
    <div className="bg-dark-500 p-2 border border-dark-400 flex">
      <div className="w-full flex cursor-pointer justify-between">
        <div className="flex">
          <div className="text-dark-number text-lg cursor-pointer w-6 text-center mr-0.5"></div>
          <div className="text-dark-method text-lg cursor-pointer w-full"></div>
        </div>
      </div>
    </div>
  );
}
