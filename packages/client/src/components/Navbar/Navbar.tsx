import { AppRoutes, routeConfig } from "../../pages/routeConfig/routeConfig";
import { AppLink } from "../utils/AppLink/AppLink";

interface NavbarProps {
  className?: string;
}

export const Navbar = ({ className }: NavbarProps) => {
  return (
    <div className={className}>
      <div className="flex items-center gap-2">
        {Object.keys(routeConfig).map((routeKey) => {
          const route = routeConfig[routeKey as AppRoutes];

          if (route.external) {
            return (
              <a
                key={routeKey}
                href={route.path}
                target="_blank"
                rel="noopener noreferrer"
              >
                <span>{routeKey.replace(/_/g, " ")}</span>
              </a>
            );
          } else {
            return (
              <AppLink key={routeKey} to={route.path}>
                <span>{routeKey.replace(/_/g, " ")}</span>
              </AppLink>
            );
          }
        })}
      </div>
    </div>
  );
};
