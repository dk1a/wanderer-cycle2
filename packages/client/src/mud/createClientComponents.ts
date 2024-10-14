import { overridableComponent } from "@latticexyz/recs";
import { SetupNetworkResult } from "./setupNetwork";

export type ClientComponents = ReturnType<typeof createClientComponents>;

export function createClientComponents({ components }: SetupNetworkResult) {
  return {
    ...components,
    GuisePrototype: overridableComponent(components.GuisePrototype),
    GuiseSkills: overridableComponent(components.GuiseSkills),
    Name: overridableComponent(components.Name),
    // SkillPrototype: overridableComponent(components.SkillPrototype),
    // SkillDescription: overridableComponent(components.SkillDescription),
  };
}
