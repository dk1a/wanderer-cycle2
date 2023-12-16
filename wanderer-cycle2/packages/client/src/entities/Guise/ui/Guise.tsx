import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './Guise.module.scss'
import {Fragment} from "react";
import {Button} from "@/shared/ui/Button/Button";
import GuiseSkill from "@/entities/GuiseSkill/ui/GuiseSkill";

interface GuiseProps{
  className?: string;
  // guise: GuiseData;
  // onSelectGuise?: (guiseEntity: EntityIndex) => void;
  // disabled: boolean;
}

const statNames = ['strength', 'arcana', 'dexterity']
const Guise = ({className}: GuiseProps) => {
  return (
    <div className={classNames(cls.Guise , {}, [className])}>
      <header className={cls.header}>{'guise.name'}</header>
      <div className={cls.subtitle}>{"// stat multipliers"}</div>

      <div className={cls.stat}>
        {statNames.map((statName) => (
          <Fragment key={statName}>
            <div className={cls.name}>
              {statName}:<span className={cls.value}>{'guise.levelMul[statName]'}</span>
            </div>
          </Fragment>
        ))}
      </div>

      <div className={cls.level}>
        <div className={cls.levelSubtitle}>{"// level / skill"}</div>
      </div>
      {/*logic map skills*/}
      <div>
        <GuiseSkill />
      </div>

      {/*logic onSelect*/}
      <div className={cls.btn}>
        <Button>
          Spawn
        </Button>
      </div>
    </div>
  );
};

export default Guise;