import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "seconds",
    "runs",
    "runsPerCopy",
    "science",
    "scienceOutput",
    "advancedIndustry",
    "advancedIndustryOutput",
    "scienceCopySpeedBonusPerLevel",
    "advancedIndustrySkillIndustryJobTimeBonusPerLevel",
  ];

  connect() {
    this.updateScience();
    this.updateAdvancedIndustry();
    this.updateTime();
  }

  updateTime() {
    this.updateScience();
    this.updateAdvancedIndustry();

    const seconds = parseInt(this.secondsTarget.value, 10);
    const runs = parseInt(this.runsTarget.value, 10);
    const runsPerCopy = parseInt(this.runsPerCopyTarget.value, 10);
    const scienceLevel = parseInt(this.scienceTarget.value, 10);
    const scienceCopySpeedBonusPerLevel = parseInt(
      this.scienceCopySpeedBonusPerLevelTarget.value,
      10
    );
    const advancedIndustryLevel = parseInt(
      this.advancedIndustryTarget.value,
      10
    );
    const advancedIndustrySkillIndustryJobTimeBonusPerLevel = parseInt(
      this.advancedIndustrySkillIndustryJobTimeBonusPerLevelTarget.value,
      10
    );

    const scienceCopyBonus = scienceLevel * scienceCopySpeedBonusPerLevel;
    const scienceCopyBonusTimeModifier = (100.0 + scienceCopyBonus) / 100.0;

    const advancedIndustryJobTimeBonus =
      advancedIndustryLevel * advancedIndustrySkillIndustryJobTimeBonusPerLevel;
    const advancedIndustryJobTimeBonusTimeModifier =
      (100.0 + advancedIndustryJobTimeBonus) / 100.0;

    const timeModifier =
      scienceCopyBonusTimeModifier * advancedIndustryJobTimeBonusTimeModifier;

    const time = seconds * timeModifier * runs * runsPerCopy;

    this.dispatch("time", { detail: { content: time } });
  }

  updateScience() {
    this.scienceOutputTarget.textContent = this.scienceTarget.value;
  }

  updateAdvancedIndustry() {
    this.advancedIndustryOutputTarget.textContent =
      this.advancedIndustryTarget.value;
  }
}
