# frozen_string_literal: true

require "rails_helper"

describe CharacterSkillsLevels do
  it { expect(described_class::SCIENCE_SKILL_ID).to eq(3402) }

  it { expect(described_class::ADVANCED_INDUSTRY_SKILL_ID).to eq(3388) }
end
