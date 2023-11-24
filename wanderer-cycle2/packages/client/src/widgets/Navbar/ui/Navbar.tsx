import { classNames } from '@/shared/lib/classNames/classNames';
import { AppLink } from '@/shared/ui/AppLink/AppLink';
import {routeConfig, RoutePath} from '@/shared/config/routeConfig';
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

// function Layout() {
//   return (
//     <div>
//       <div className={`flex flex-row flex-wrap items-center justify-around h-16 ${bg} border border-dark-400`}>
//         <div>
//           <CustomButton className="w-20" onClick={toggleWandererMode}>
//             {wandererMode ? "return" : "void"}
//           </CustomButton>
//         </div>
//         <nav className="flex flex-wrap items-center justify-around w-2/3">
//           {[...gameRoutes, ...otherRoutes].map(({ title, path }) => (
//             <NavLink
//               key={path}
//               className={({ isActive }) => `transition duration-700 text-lg ${isActive ? "" : "text-dark-300"}`}
//               to={path}
//             >
//               {title}
//             </NavLink>
//           ))}
//           <div className="flex gap-x-8 text-dark-300">
//             <NavLink to={"https://github.com/dk1a/wanderer-cycle"} target={"_blank"}>
//               github
//             </NavLink>
//             <NavLink to={"https://discord.gg/9pX3h53VnX"} target={"_blank"}>
//               discord
//             </NavLink>
//           </div>
//         </nav>
//       </div>
//       <Outlet />
//     </div>
//   );
// }