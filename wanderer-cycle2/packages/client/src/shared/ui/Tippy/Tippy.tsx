import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './Tippy.module.scss'

interface TippyProps{
  className?: string;
}

const Tippy = ({className}: TippyProps) => {
  return (
    <div className={classNames(cls.Tippy , {}, [className])}>

    </div>
  );
};

export default Tippy;