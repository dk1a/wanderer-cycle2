import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './WandrerSelect.module.scss'

interface WandrerSelectProps{
  className?: string;
}

const WandrerSelect = ({className}: WandrerSelectProps) => {
  return (
    <div className={classNames(cls.WandrerSelect , {}, [className])}>
      
    </div>
  );
};

export default WandrerSelect;