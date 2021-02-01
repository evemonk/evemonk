# frozen_string_literal: true

require "rails_helper"

describe Eve::CharacterAttributeDecorator do
  xdescribe "#description" do
    let(:eve_character_attribute) do
      build(:eve_character_attribute,
        description: "<b>Test</b>")
    end

    subject { eve_character_attribute.decorate }

    specify { expect(subject.description).to eq("Test") }
  end
end
