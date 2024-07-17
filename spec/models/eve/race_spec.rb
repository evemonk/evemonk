# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Race do
  it { is_expected.to be_an(ApplicationRecord) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_races") }

  it { is_expected.to belong_to(:faction).optional }

  it { is_expected.to have_many(:bloodlines) }

  it { is_expected.to have_many(:stations) }
end
