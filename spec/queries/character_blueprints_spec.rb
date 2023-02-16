# frozen_string_literal: true

require "rails_helper"

describe CharacterBlueprints do
  let(:character) { double }

  let(:filter) { double }

  subject { described_class.new(character, filter) }

  describe "#initialize" do
    its(:character) { should eq(character) }

    its(:filter) { should eq(filter) }
  end

  describe "#query" do
    context "when @character_blueprints is already set" do
      let(:character_blueprints) { double }

      before { subject.instance_variable_set(:@character_blueprints, character_blueprints) }

      specify { expect(subject.query).to eq(character_blueprints) }
    end

    context "when no filters" do
      let(:filter) { nil }

      before do
        #
        # character.character_blueprints
        #          .joins(blueprint: :group)
        #          .order("eve_types.name_en": :asc)
        #
        expect(character).to receive(:character_blueprints) do
          double.tap do |a|
            expect(a).to receive(:joins).with(blueprint: :group) do
              double.tap do |b|
                expect(b).to receive(:order).with("eve_types.name_en": :asc)
              end
            end
          end
        end
      end

      specify { expect { subject.query }.not_to raise_error }
    end

    context "when filter is present" do
      let!(:character) { create(:character) }

      let!(:eve_category_1) { create(:eve_category) }

      let!(:eve_group_1) { create(:eve_group, category: eve_category_1) }

      let!(:eve_category_2) { create(:eve_category) }

      let!(:eve_group_2) { create(:eve_group, category: eve_category_2) }

      let!(:eve_category_3) { create(:eve_category, id: Eve::Categories::ANCIENT_RELICS_ID) }

      let!(:eve_group_3) { create(:eve_group, category: eve_category_3) }

      let!(:eve_blueprint_1) do
        Eve::Blueprint.create!(
          attributes_for(:eve_type,
            name_en: "Damage Control I Blueprint",
            group: eve_group_1)
        )
      end

      let!(:eve_blueprint_2) do
        Eve::Blueprint.create!(
          attributes_for(:eve_type,
            name_en: "125mm Railgun I Blueprint",
            group: eve_group_2)
        )
      end

      let!(:eve_blueprint_3) do
        Eve::Blueprint.create!(
          attributes_for(:eve_type,
            name_en: "Wrecked Hull Section",
            group: eve_group_3)
        )
      end

      let!(:character_blueprint_1) { create(:character_blueprint, character: character, blueprint: eve_blueprint_1, quantity: -1) }

      let!(:character_blueprint_2) { create(:character_blueprint, character: character, blueprint: eve_blueprint_2, quantity: -2) }

      let!(:character_blueprint_3) { create(:character_blueprint, character: character, blueprint: eve_blueprint_3, quantity: 2) }

      context "when All" do
        let(:filter) { "0" }

        specify { expect(subject.query).to eq([character_blueprint_2, character_blueprint_1, character_blueprint_3]) }
      end

      context "when BPO" do
        let(:filter) { "1" }

        specify { expect(subject.query).to eq([character_blueprint_1]) }
      end

      context "when BPC" do
        let(:filter) { "2" }

        specify { expect(subject.query).to eq([character_blueprint_2]) }
      end

      context "when Ancient Relics" do
        let(:filter) { "3" }

        specify { expect(subject.query).to eq([character_blueprint_3]) }
      end

      context "when Stacked" do
        let(:filter) { "4" }

        specify { expect(subject.query).to eq([character_blueprint_3]) }
      end

      context "when filter is unknown" do
        let(:filter) { "100" }

        specify { expect(subject.query).to eq([character_blueprint_2, character_blueprint_1, character_blueprint_3]) }
      end
    end
  end
end
