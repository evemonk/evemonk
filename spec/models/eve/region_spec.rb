# frozen_string_literal: true

require "rails_helper"

describe Eve::Region do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("region_id") }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_regions") }

  it { should have_many(:constellations) }

  it { should have_many(:contracts) }
end
