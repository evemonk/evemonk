# frozen_string_literal: true

require "rails_helper"

describe Eve::CharacterAttribute do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name"]) }

  it { expect(described_class.table_name).to eq("eve_character_attributes") }

  it { should belong_to(:icon).optional(true) }

  describe "#sanitized_description" do
    subject do
      build(:eve_character_attribute,
        description: "<b>Test</b>")
    end

    specify { expect(subject.sanitized_description).to eq("Test") }
  end
end
