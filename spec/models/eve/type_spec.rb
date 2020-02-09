# frozen_string_literal: true

require "rails_helper"

describe Eve::Type do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class).to respond_to(:search) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.translated_attribute_names).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_types") }

  it { should belong_to(:graphic).with_primary_key("graphic_id").optional(true) }

  it { should belong_to(:group).with_primary_key("group_id").optional(true) }

  it { should belong_to(:icon).with_primary_key("icon_id").optional(true) }

  it { should belong_to(:market_group).with_primary_key("market_group_id").optional(true) }

  it { should have_many(:type_dogma_attributes).with_primary_key("type_id").with_foreign_key("type_id").dependent(:destroy) }

  it { should have_many(:type_dogma_effects).with_primary_key("type_id").with_foreign_key("type_id").dependent(:destroy) }

  describe "#search_data" do
    let!(:type) do
      build(:eve_type,
        name_en: "Ragnarok1",
        name_de: "Ragnarok2",
        name_fr: "Ragnarok3",
        name_ja: "ラグナロク",
        name_ru: "Ragnarok4",
        name_zh: "拉格纳洛克级",
        name_ko: "라그나로크")
    end

    specify do
      expect(type.search_data).to eq(name_en: "Ragnarok1",
                                     name_de: "Ragnarok2",
                                     name_fr: "Ragnarok3",
                                     name_ja: "ラグナロク",
                                     name_ru: "Ragnarok4",
                                     name_zh: "拉格纳洛克级",
                                     name_ko: "라그나로크")
    end
  end

  describe "#implant_bonuses" do
    context "when @implant_bonuses is set" do
      let(:implant_bonuses) { double }

      before { subject.instance_variable_set(:@implant_bonuses, implant_bonuses) }

      specify { expect(subject.implant_bonuses).to eq(implant_bonuses) }
    end

    context "when @implant_bonuses is not set" do
      let(:implant_bonuses) { instance_double(Eve::ImplantBonuses) }

      let(:out) { double }

      before { expect(Eve::ImplantBonuses).to receive(:new).with(subject).and_return(implant_bonuses) }

      before { expect(implant_bonuses).to receive(:implant_bonuses).and_return(out) }

      specify { expect(subject.implant_bonuses).to eq(out) }

      specify { expect { subject.implant_bonuses }.to change { subject.instance_variable_get(:@implant_bonuses) }.from(nil).to(out) }
    end
  end
end
