# frozen_string_literal: true

require "rails_helper"

describe Eve::DogmaAttributes do
  it { expect(described_class::COPY_SPEED_BONUS).to eq("copySpeedBonus") }

  it { expect(described_class::ADVANCED_INDUSTRY_SKILL_INDUSTRY_JOB_TIME_BONUS).to eq("advancedIndustrySkillIndustryJobTimeBonus") }

  describe ".copy_speed_bonus" do
    let!(:dogma_attribute) do
      create(:eve_dogma_attribute,
        name: described_class::COPY_SPEED_BONUS,
        published: true)
    end

    specify { expect(described_class.copy_speed_bonus).to eq(dogma_attribute) }
  end

  describe ".advanced_industry_skill_industry_job_time_bonus" do
    let!(:dogma_attribute) do
      create(:eve_dogma_attribute,
        name: described_class::ADVANCED_INDUSTRY_SKILL_INDUSTRY_JOB_TIME_BONUS,
        published: true)
    end

    specify { expect(described_class.advanced_industry_skill_industry_job_time_bonus).to eq(dogma_attribute) }
  end
end
