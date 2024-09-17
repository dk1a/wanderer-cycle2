// import {useLocation} from "react-router-dom";
// import {Button} from "../utils/Button/Button";
import { routeConfig } from "../../pages/routeConfig/routeConfig";
import { AppLink } from "../utils/AppLink/AppLink";

interface NavbarProps {
  className?: string;
}

export const Navbar = ({ className }: NavbarProps) => {
  // const location = useLocation();

  return (
    <div className={className}>
      <div>
        {Object.keys(routeConfig).map((routeKey) => {
          const route = routeConfig[routeKey];

          return (
            <AppLink className={"mx-2"} key={routeKey} to={route.path}>
              <span>{routeKey.replace(/_/g, " ")}</span>
            </AppLink>
          );
        })}
      </div>
    </div>
  );
};
