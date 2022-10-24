# frozen_string_literal: true

module Eve
  class DogmaAttributes
    COPY_SPEED_BONUS = "copySpeedBonus"
    ADVANCED_INDUSTRY_SKILL_INDUSTRY_JOB_TIME_BONUS = "advancedIndustrySkillIndustryJobTimeBonus"

    class << self
      def copy_speed_bonus
        Eve::DogmaAttribute.published.find_by!(name: COPY_SPEED_BONUS)
      end

      def advanced_industry_skill_industry_job_time_bonus
        Eve::DogmaAttribute.published.find_by!(name: ADVANCED_INDUSTRY_SKILL_INDUSTRY_JOB_TIME_BONUS)
      end
    end
  end
end
