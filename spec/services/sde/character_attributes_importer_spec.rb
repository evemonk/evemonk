# frozen_string_literal: true

require "rails_helper"

describe Sde::CharacterAttributesImporter do
  let(:file) { double }

  subject { described_class.new(file) }

  describe "#initialize" do
    its(:file) { should eq(file) }
  end

  describe "#import" do
    let(:content) { double }

    before { expect(File).to receive(:read).with(file).and_return(content) }

    let(:attribute_id) { double }

    let(:attribute_name) { double }

    let(:description) { double }

    let(:icon_id) { double }

    let(:notes) { double }

    let(:short_description) { double }

    let(:entry) do
      {
        "attributeID" => attribute_id,
        "attributeName" => attribute_name,
        "description" => description,
        "iconID" => icon_id,
        "notes" => notes,
        "shortDescription" => short_description,
      }
    end

    let(:entries) { [entry] }

    before { expect(YAML).to receive(:safe_load).with(content).and_return(entries) }

    let(:eve_character_attribute) { instance_double(Eve::CharacterAttribute) }

    before { expect(Eve::CharacterAttribute).to receive(:find_or_initialize_by).with(attribute_id: attribute_id).and_return(eve_character_attribute) }

    before do
      expect(eve_character_attribute).to receive(:assign_attributes).with(attribute_name: attribute_name,
                                                                          description: description,
                                                                          icon_id: icon_id,
                                                                          notes: notes,
                                                                          short_description: short_description)
    end

    before { expect(eve_character_attribute).to receive(:save!) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
