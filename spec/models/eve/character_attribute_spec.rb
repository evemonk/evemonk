# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::CharacterAttribute do
  it { is_expected.to be_an(ApplicationRecord) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name"]) }

  it { expect(described_class.table_name).to eq("eve_character_attributes") }

  it { is_expected.to belong_to(:icon).optional }

  describe "#sanitized_description" do
    subject do
      build(:eve_character_attribute,
        description: "<b>Test</b>")
    end

    specify { expect(subject.sanitized_description).to eq("Test") }
  end
end
