// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

import { Tasks, TasksData } from "./tables/Tasks.sol";
import { GameConfig, GameConfigData } from "./tables/GameConfig.sol";
import { Name } from "./tables/Name.sol";
import { DefaultWheel } from "./tables/DefaultWheel.sol";
import { Wheel, WheelData } from "./tables/Wheel.sol";
import { Experience } from "./tables/Experience.sol";
import { AffixAvailable } from "./tables/AffixAvailable.sol";
import { AffixNaming } from "./tables/AffixNaming.sol";
import { AffixPrototype, AffixPrototypeData } from "./tables/AffixPrototype.sol";
import { AffixProtoIndex } from "./tables/AffixProtoIndex.sol";
import { AffixProtoGroup } from "./tables/AffixProtoGroup.sol";
import { Affix, AffixData } from "./tables/Affix.sol";
import { ActiveGuise } from "./tables/ActiveGuise.sol";
import { GuisePrototype } from "./tables/GuisePrototype.sol";
import { GuiseSkills } from "./tables/GuiseSkills.sol";
import { GuiseNameToEntity } from "./tables/GuiseNameToEntity.sol";
import { LearnedSkills } from "./tables/LearnedSkills.sol";
import { LifeCurrent } from "./tables/LifeCurrent.sol";
import { ManaCurrent } from "./tables/ManaCurrent.sol";
import { LootAffixes } from "./tables/LootAffixes.sol";
import { LootIlvl } from "./tables/LootIlvl.sol";
import { SkillTemplate, SkillTemplateData } from "./tables/SkillTemplate.sol";
import { SkillSpellDamage } from "./tables/SkillSpellDamage.sol";
import { SkillTemplateCooldown, SkillTemplateCooldownData } from "./tables/SkillTemplateCooldown.sol";
import { SkillTemplateDuration, SkillTemplateDurationData } from "./tables/SkillTemplateDuration.sol";
import { SkillDescription } from "./tables/SkillDescription.sol";
import { SkillNameToEntity } from "./tables/SkillNameToEntity.sol";
import { SkillCooldown, SkillCooldownData } from "./tables/SkillCooldown.sol";
import { ActiveCycle } from "./tables/ActiveCycle.sol";
import { CycleToWanderer } from "./tables/CycleToWanderer.sol";
import { CurrentCycle } from "./tables/CurrentCycle.sol";
import { PreviousCycle } from "./tables/PreviousCycle.sol";
import { CycleTurns } from "./tables/CycleTurns.sol";
import { CycleTurnsLastClaimed } from "./tables/CycleTurnsLastClaimed.sol";
import { ActiveWheel } from "./tables/ActiveWheel.sol";
import { Identity } from "./tables/Identity.sol";
import { Wanderer } from "./tables/Wanderer.sol";
import { WheelsCompleted } from "./tables/WheelsCompleted.sol";
import { ActiveCombat, ActiveCombatData } from "./tables/ActiveCombat.sol";
import { RNGPrecommit } from "./tables/RNGPrecommit.sol";
import { RNGRequestOwner } from "./tables/RNGRequestOwner.sol";
import { SlotAllowedTypes } from "./tables/SlotAllowedTypes.sol";
import { SlotEquipment } from "./tables/SlotEquipment.sol";
import { OwnedBy } from "./tables/OwnedBy.sol";
import { MapTypeComponent } from "./tables/MapTypeComponent.sol";
import { MapTypeAffixAvailability } from "./tables/MapTypeAffixAvailability.sol";
import { GenericDuration, GenericDurationData } from "./tables/GenericDuration.sol";
import { DurationIdxList } from "./tables/DurationIdxList.sol";
import { DurationIdxMap } from "./tables/DurationIdxMap.sol";
import { StatmodBase, StatmodBaseData } from "./tables/StatmodBase.sol";
import { StatmodValue } from "./tables/StatmodValue.sol";
import { StatmodIdxList } from "./tables/StatmodIdxList.sol";
import { StatmodIdxMap } from "./tables/StatmodIdxMap.sol";
import { EffectDuration, EffectDurationData } from "./tables/EffectDuration.sol";
import { EffectTemplate, EffectTemplateData } from "./tables/EffectTemplate.sol";
import { EffectApplied, EffectAppliedData } from "./tables/EffectApplied.sol";
