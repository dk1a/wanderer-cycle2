import { classNames } from '@/shared/lib/classNames/classNames';
import { AppLink } from '@/shared/ui/AppLink/AppLink';
import {routeConfig} from '@/shared/config/routeConfig';
import cls from './Navbar.module.scss';
import {useLocation} from "react-router-dom";

interface NavbarProps {
  className?: string;
}

export const Navbar = ({ className }: NavbarProps) => {
  const location = useLocation();

  return (
    <div className={classNames(cls.Navbar, {}, [className])}>
      <div className={cls.items}>

        {Object.keys(routeConfig).map((routeKey) => {
          const route = routeConfig[routeKey];
          const isActive = location.pathname === route.path

          return (
            <AppLink key={routeKey} to={route.path} className={cls.item}>
              <span className={classNames(cls.link, { [cls.active]: isActive })}>
                {routeKey.replace(/_/g, ' ')}
              </span>
            </AppLink>
          );
        })}
      </div>
    </div>
  );
};
