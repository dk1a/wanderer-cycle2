import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './GuiseSkill.module.scss'
import { Tooltip } from 'react-tooltip'
import {Skill} from "@/entities/Skill";

interface GuiseSkillProps{
  className?: string;
}

const GuiseSkill = ({className}: GuiseSkillProps) => {
  return (
    <div className={classNames(cls.GuiseSkill , {}, [className])}>
      <div className={cls.container}>
        <div className={cls.containerName}>
          <div className={cls.number}>{'skill.requiredLevel'}.</div>
          <div className={cls.name}>{'skill.name'}</div>
        </div>
      </div>
      <Tooltip anchorSelect={"." + cls.container} place={'top'} className={cls.tooltip}>
        <Skill />
      </Tooltip>
    </div>
  );
};

export default GuiseSkill;