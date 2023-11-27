import { classNames } from '@/shared/lib/classNames/classNames';
import { AppLink } from '@/shared/ui/AppLink/AppLink';
import {routeConfig} from '@/shared/config/routeConfig';
import cls from './Navbar.module.scss';

interface NavbarProps {
  className?: string;
}

export const Navbar = ({ className }: NavbarProps) => {
  return (
    <div className={classNames(cls.Navbar, {}, [className])}>
      <div className={cls.items}>
        {Object.keys(routeConfig).map((routeKey) => {
          const route = routeConfig[routeKey];
          return (
            <AppLink key={routeKey} to={route.path} className={cls.item}>
              <span className={cls.link}>
                {routeKey.replace(/_/g, ' ')}
              </span>
            </AppLink>
          );
        })}
      </div>
    </div>
  );
};
