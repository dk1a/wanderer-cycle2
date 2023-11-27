import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './WandererSelect.module.scss'

interface WandererSelectProps{
  className?: string;
}

const WandererSelect = ({className}: WandererSelectProps) => {
  return (
    <div className={classNames(cls.WandrerSelect , {}, [className])}>
      
    </div>
  );
};

export default WandererSelect;