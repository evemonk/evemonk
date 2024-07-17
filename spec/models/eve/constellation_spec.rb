# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Constellation do
  it { is_expected.to be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("constellation_id") }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name"]) }

  it { expect(described_class.table_name).to eq("eve_constellations") }

  it { is_expected.to belong_to(:region).optional }

  it { is_expected.to have_many(:systems) }

  it { is_expected.to have_one(:position).dependent(:destroy) }
end
