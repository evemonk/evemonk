# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Bloodline do
  it { is_expected.to be_an(ApplicationRecord) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_bloodlines") }

  it { is_expected.to belong_to(:corporation).optional }

  it { is_expected.to belong_to(:race).optional }

  it { is_expected.to belong_to(:ship_type).class_name("Eve::Ship").optional }

  it { is_expected.to have_many(:ancestries) }
end
