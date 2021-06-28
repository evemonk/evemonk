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

    let(:key) { double }

    let(:description) { double }

    let(:icon_id) { double }

    let(:name_de) { double }

    let(:name_en) { double }

    let(:name_fr) { double }

    let(:name_ja) { double }

    let(:name_ko) { double }

    let(:name_ru) { double }

    let(:notes) { double }

    let(:short_description) { double }

    let(:entry) do
      {
        "description" => description,
        "iconID" => icon_id,
        "nameID" => {
          "de" => name_de,
          "en" => name_en,
          "fr" => name_fr,
          "ja" => name_ja,
          "ko" => name_ko,
          "ru" => name_ru
        },
        "notes" => notes,
        "shortDescription" => short_description
      }
    end

    let(:entries) { {key => entry} }

    before { expect(YAML).to receive(:safe_load).with(content).and_return(entries) }

    let(:eve_character_attribute) { instance_double(Eve::CharacterAttribute) }

    before { expect(Eve::CharacterAttribute).to receive(:find_or_initialize_by).with(attribute_id: key).and_return(eve_character_attribute) }

    before do
      expect(eve_character_attribute).to receive(:assign_attributes).with(name_en: name_en,
        name_de: name_de,
        name_fr: name_fr,
        name_ja: name_ja,
        name_ko: name_ko,
        name_ru: name_ru,
        description: description,
        icon_id: icon_id,
        notes: notes,
        short_description: short_description)
    end

    before { expect(eve_character_attribute).to receive(:save!) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
