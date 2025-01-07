# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Categories, type: :model do
  it { expect(described_class::SKILLS_ID).to eq(16) }

  it { expect(described_class::ANCIENT_RELICS_ID).to eq(34) }
end
