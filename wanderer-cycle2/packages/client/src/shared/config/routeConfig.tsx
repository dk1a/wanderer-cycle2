import { RouteProps } from 'react-router-dom';
import {AboutPage} from "@/pages/AboutPage";
import {NotFoundPage} from "@/pages/NotFoundPage";
import {WandrerSelect} from "@/pages/WandererSelect";
import {InventoryPage} from "@/pages/InventoryPage";
import {MapsPage} from "@/pages/MapsPage";
import {SkillPage} from "@/pages/SkillPage";
import {CyclePage} from "@/pages/CyclePage";

export enum AppRoutes {
  WANDERER_SELECT = 'wanderer_select',
  MAPS = 'maps',
  INVENTORY = 'inventory',
  SKILLS = 'skills',
  CYCLE = 'cycle',
  ABOUT = 'about',
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
  [AppRoutes.WANDERER_SELECT]: {
    path: RoutePath.wanderer_select,
    element: <WandrerSelect />,
  },
  [AppRoutes.MAPS]: {
    path: RoutePath.maps,
    element: <MapsPage />,
  },
  [AppRoutes.INVENTORY]: {
    path: RoutePath.inventory,
    element: <InventoryPage />,
  },
  [AppRoutes.SKILLS]: {
    path: RoutePath.skills,
    element: <SkillPage />,
  },
  [AppRoutes.CYCLE]: {
    path: RoutePath.cycle,
    element: <CyclePage />,
  },
  [AppRoutes.ABOUT]: {
    path: RoutePath.about,
    element: <AboutPage />,
  },
  [AppRoutes.NOT_FOUND]: {
    path: RoutePath.not_found,
    element: <NotFoundPage />,
  },
  [AppRoutes.GITHUB]: {
    path: RoutePath.about,
    element: '',
  },
  [AppRoutes.DISCORD]: {
    path: RoutePath.not_found,
    element: '',
  },
};
