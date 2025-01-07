# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Region, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("region_id") }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_regions") }

  it { expect(subject).to have_many(:constellations) }

  it { expect(subject).to have_many(:contracts) }
end
