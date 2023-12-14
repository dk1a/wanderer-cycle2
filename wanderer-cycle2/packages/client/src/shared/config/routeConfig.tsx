import {Link, RouteProps} from 'react-router-dom';
import {AboutPage} from "@/pages/AboutPage";
import {NotFoundPage} from "@/pages/NotFoundPage";
import {WandererSelect} from "@/pages/WandererSelect";
import {InventoryPage} from "@/pages/InventoryPage";
import {MapsPage} from "@/pages/MapsPage";
import {SkillPage} from "@/pages/SkillPage";
import {CyclePage} from "@/pages/CyclePage";

export enum AppRoutes {
  WANDERER_SELECT = 'Wanderer-select',
  MAPS = 'Maps',
  INVENTORY = 'Inventory',
  SKILLS = 'Skills',
  CYCLE = 'Cycle',
  ABOUT = 'About',
  NOT_FOUND = 'not_found',
  DISCORD = 'discord',
  GITHUB = 'github'
}

export const RoutePath: Record<AppRoutes, string> = {
  [AppRoutes.WANDERER_SELECT]: '/',
  [AppRoutes.MAPS]: '/maps',
  [AppRoutes.INVENTORY]: '/inventory',
  [AppRoutes.SKILLS]: '/skills',
  [AppRoutes.CYCLE]: '/cycle',
  [AppRoutes.ABOUT]: '/about',
  [AppRoutes.NOT_FOUND]: '*',
  [AppRoutes.DISCORD]: 'https://discord.gg/9pX3h53VnX',
  [AppRoutes.GITHUB]: 'https://github.com/dk1a/wanderer-cycle',
};

export const routeConfig: Record<AppRoutes, RouteProps> = {
  [AppRoutes.MAPS]: {
    path: RoutePath.Maps,
    element: <MapsPage />,
  },
  [AppRoutes.INVENTORY]: {
    path: RoutePath.Inventory,
    element: <InventoryPage />,
  },
  [AppRoutes.SKILLS]: {
    path: RoutePath.Skills,
    element: <SkillPage />,
  },
  [AppRoutes.CYCLE]: {
    path: RoutePath.Cycle,
    element: <CyclePage />,
  },
  [AppRoutes.WANDERER_SELECT]: {
    path: RoutePath["Wanderer-select"],
    element: <WandererSelect />,
  },
  [AppRoutes.GITHUB]: {
    path: RoutePath.github,
    element: '',
  },
  [AppRoutes.DISCORD]: {
    path: RoutePath.discord,
    element: '',
  },
  // [AppRoutes.ABOUT]: {
  //   path: RoutePath.about,
  //   element: <AboutPage />,
  // },
  // [AppRoutes.NOT_FOUND]: {
  //   path: RoutePath.not_found,
  //   element: <NotFoundPage />,
  // },
};
