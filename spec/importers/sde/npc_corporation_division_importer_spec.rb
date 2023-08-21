# frozen_string_literal: true

require "rails_helper"

describe Sde::NpcCorporationDivisionImporter do
  let(:file) { double }

  subject { described_class.new(file) }

  describe "#initialize" do
    its(:file) { should eq(file) }
  end

  describe "#import" do
    let(:key) { double }

    let(:description) { double }

    let(:description_full_en) { double }

    let(:description_full_de) { double }

    let(:description_full_fr) { double }

    let(:description_full_ja) { double }

    let(:description_full_ko) { double }

    let(:description_full_ru) { double }

    let(:description_full_zh) { double }

    let(:internal_name) { double }

    let(:leader_type_name_en) { double }

    let(:leader_type_name_de) { double }

    let(:leader_type_name_fr) { double }

    let(:leader_type_name_ja) { double }

    let(:leader_type_name_ko) { double }

    let(:leader_type_name_ru) { double }

    let(:leader_type_name_zh) { double }

    let(:name_en) { double }

    let(:name_de) { double }

    let(:name_fr) { double }

    let(:name_ja) { double }

    let(:name_ko) { double }

    let(:name_ru) { double }

    let(:name_zh) { double }

    let(:entry) do
      {
        "description" => description,
        "descriptionID" => {
          "en" => description_full_en,
          "de" => description_full_de,
          "fr" => description_full_fr,
          "ja" => description_full_ja,
          "ko" => description_full_ko,
          "ru" => description_full_ru,
          "zh" => description_full_zh
        },
        "internalName" => internal_name,
        "leaderTypeNameID" => {
          "en" => leader_type_name_en,
          "de" => leader_type_name_de,
          "fr" => leader_type_name_fr,
          "ja" => leader_type_name_ja,
          "ko" => leader_type_name_ko,
          "ru" => leader_type_name_ru,
          "zh" => leader_type_name_zh
        },
        "nameID" => {
          "en" => name_en,
          "de" => name_de,
          "fr" => name_fr,
          "ja" => name_ja,
          "ko" => name_ko,
          "ru" => name_ru,
          "zh" => name_zh
        }
      }
    end

    let(:entries) { {key => entry} }

    before { expect(YAML).to receive(:safe_load_file).with(file).and_return(entries) }

    let(:eve_division) { instance_double(Eve::Division) }

    before { expect(Eve::Division).to receive(:find_or_initialize_by).with({id: key}).and_return(eve_division) }

    before do
      expect(eve_division).to receive(:assign_attributes).with({
        description: description,
        description_full_en: description_full_en,
        description_full_de: description_full_de,
        description_full_fr: description_full_fr,
        description_full_ja: description_full_ja,
        description_full_ko: description_full_ko,
        description_full_ru: description_full_ru,
        description_full_zh: description_full_zh,
        internal_name: internal_name,
        leader_type_name_en: leader_type_name_en,
        leader_type_name_de: leader_type_name_de,
        leader_type_name_fr: leader_type_name_fr,
        leader_type_name_ja: leader_type_name_ja,
        leader_type_name_ko: leader_type_name_ko,
        leader_type_name_ru: leader_type_name_ru,
        leader_type_name_zh: leader_type_name_zh,
        name_en: name_en,
        name_de: name_de,
        name_fr: name_fr,
        name_ja: name_ja,
        name_ko: name_ko,
        name_ru: name_ru,
        name_zh: name_zh
      })
    end

    before { expect(eve_division).to receive(:save!) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
