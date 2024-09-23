import { Tooltip } from "react-tooltip";

interface GuiseSkillProps {
  className?: string;
}

export const GuiseSkill = ({ className }: GuiseSkillProps) => {
  return (
    <div className={"bg-dark-500 p-2 border border-dark-400 flex " + className}>
      <div className={"w-full flex cursor-pointer justify-between"}>
        <div className={"flex"}>
          <div
            className={
              "text-dark-number text-lg cursor-pointer w-6 text-center mr-0.5"
            }
          >
            {"skill.requiredLevel"}.
          </div>
          <div className={"text-dark-method text-lg cursor-pointer w-full"}>
            {"skill.name"}
          </div>
        </div>
      </div>
      <Tooltip anchorSelect={"."} place={"top"} className={}>
        {/*<Skill />*/}
      </Tooltip>
    </div>
  );
};
