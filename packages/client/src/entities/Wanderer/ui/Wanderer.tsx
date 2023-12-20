import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './Wanderer.module.scss'

interface WandererProps{
  className?: string;
}

const Wanderer = ({className}: WandererProps) => {
  return (
    <div className={classNames(cls.Wanderer , {}, [className])}>

    </div>
  );
};

export default Wanderer;