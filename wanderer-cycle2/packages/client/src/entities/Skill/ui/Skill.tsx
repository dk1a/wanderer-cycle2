import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './Skill.module.scss'
import { SkillEffectStatmod } from "@/entities/SkillEffectStatmod";

interface SkillProps{
  className?: string;
  isCollapsed?: boolean;
}

const Skill = ({className, isCollapsed = false}: SkillProps) => {
  return (
    <div className={classNames(cls.Skill , {}, [className])}>
      <div className={cls.name}>
        {'skill.name'}
        <div className={cls.level}>
          requiredLevel: <span className={cls.number}>{'skill.requiredLevel'}</span>
        </div>
      </div>
      {!isCollapsed && (
        <div>
          <div className={cls.description}>{`// $'{skill.description}'`}</div>
          <div className=''>
            <div className="">
              <div>
                <span className={cls.type}>type: </span>
                <span className={cls.string}>{'skill.skillTypeName'}</span>
              </div>
              {/*{skill.skillType !== SkillType.PASSIVE && (*/}
              <div>
                <span className={cls.type}>cost: </span>
                <span className={cls.number}>{'skill.cost'}</span>
                <span className={cls.string}>mana</span>
              </div>
              {/*)}*/}

              {/*{skill.duration.timeValue > 0 && (*/}
              <div className={cls.container}>
                <span className={cls.type}>duration:</span>
                <span className={cls.number}>{'skill.duration.timeValue'}</span>
                <span className={cls.string}> {'skill.duration.timeScopeName'}</span>
              </div>
              {/*)}*/}
              {/*{skill.cooldown.timeValue > 0 && (*/}
              <div className={cls.container}>
                <span className={cls.type}>cooldown: </span>
                <span className={cls.number}>{'skill.cooldown.timeValue'}</span>
                <span className={cls.string}> {'skill.cooldown.timeScopeName'}</span>
              </div>
              {/*)}*/}
              {/*{effect !== undefined && effect.statmods !== undefined && (*/}
              <div className="p-0.5 w-full mt-4">
                <div className="">
                  <span className={cls.type}>
                    effectTarget: <span className={cls.string}>{'skill.effectTargetName'}</span>
                  </span>
                </div>
                {/*{effect.statmods.map((statmod) => (*/}
                <SkillEffectStatmod
                  // key={statmod.protoEntity} statmod={statmod}
                />
                {/*))}*/}
              </div>
              {/*)}*/}
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default Skill;