import {classNames} from "@/shared/lib/classNames/classNames";
import cls from './Wanderer.module.scss'
import {Button} from "@/shared/ui/Button/Button";

interface WandererProps{
  className?: string;
}

const Wanderer = ({className}: WandererProps) => {
  return (
    <div className={classNames(cls.Wanderer , {}, [className])}>
        //Todo image
      {/*<WandererImage entity={wandererEntity} />*/}
      <div className={cls.btn}>
        <Button disabled={true}>
          Selected
        </Button>
        <Button>
          Select
        </Button>
      </div>
    </div>
  );
};

export default Wanderer;
