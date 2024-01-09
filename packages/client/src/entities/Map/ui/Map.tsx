import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './Map.module.scss'
import { Effect } from "@/entities/Effect";
import {Button} from "@/shared/ui/Button/Button";

interface MapProps{
  className?: string;
  base?: boolean;
}

const Map = ({className, base = false}: MapProps) => {
  if (base){
    return (
      <div className={cls.MapBase}>
        <Button>
          {"name"}
        </Button>
        <div className={cls.description}>
          <span className={cls.level}>level: </span>
          <span className={classNames(cls.number, {}, [])}>{'ilvl'}</span>
        </div>
      </div>
    )
  }
  return (
    <div className={classNames(cls.Map , {}, [className])}>
      <Button>
        {"name"}
      </Button>
      <div className={cls.description}>
        <span className={cls.level}>level: </span>
        <span className={cls.number}>{"ilvl"}</span>
      </div>
      <Effect
        // entity={effect.entity}
        // protoEntity={entity}
        // removability={effect.removability}
        // statmods={effect.statmods}
        // effectSource={EffectSource.MAP}
      />
    </div>
  );
};
export default Map;