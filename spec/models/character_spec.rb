# frozen_string_literal: true

require "rails_helper"

describe Character do
  it { should be_a(ApplicationRecord) }

  it { should belong_to(:user) }

  it { should belong_to(:race).class_name("Eve::Race").with_primary_key("race_id").optional(true) }

  it { should belong_to(:bloodline).class_name("Eve::Bloodline").with_primary_key("bloodline_id").optional(true) }

  it { should belong_to(:faction).class_name("Eve::Faction").with_primary_key("faction_id").optional(true) }

  it { should belong_to(:ancestry).class_name("Eve::Ancestry").with_primary_key("ancestry_id").optional(true) }

  it { should belong_to(:alliance).class_name("Eve::Alliance").with_primary_key("alliance_id").optional(true) }

  it { should belong_to(:corporation).class_name("Eve::Corporation").with_primary_key("corporation_id").optional(true) }

  it { should belong_to(:current_ship_type).class_name("Eve::Type").with_primary_key("type_id").with_foreign_key("current_ship_type_id").optional(true) }

  it { should have_many(:loyalty_points).dependent(:destroy) }

  it { should have_many(:character_assets).dependent(:destroy) }

  it { should have_many(:character_implants).dependent(:destroy) }

  it { should have_many(:implants).through(:character_implants) }

  it { should have_many(:skillqueues).dependent(:destroy) }

  it { should have_many(:character_skills).dependent(:destroy) }

  it { should have_many(:character_corporation_histories).with_primary_key("character_id").dependent(:destroy) }

  it { should have_many(:character_mail_labels).dependent(:destroy) }

  describe "#charisma_attribute" do
    context "when @charisma_attribute is set" do
      let(:eve_charisma_attribute) { double }

      before { subject.instance_variable_set(:@charisma_attribute, eve_charisma_attribute) }

      specify { expect(subject.charisma_attribute).to eq(eve_charisma_attribute) }
    end

    context "when @charisma_attribute is not set" do
      let(:eve_charisma_attribute) { instance_double(Eve::CharacterAttribute) }

      before do
        #
        # Eve::CharacterAttribute.find_by(attribute_name: "Charisma") # => eve_charisma_attribute
        #
        expect(Eve::CharacterAttribute).to receive(:find_by).with(attribute_name: "Charisma").and_return(eve_charisma_attribute)
      end

      let(:eve_charisma_attribute_decorated) { double }

      before { expect(eve_charisma_attribute).to receive(:decorate).and_return(eve_charisma_attribute_decorated) }

      specify { expect(subject.charisma_attribute).to eq(eve_charisma_attribute_decorated) }
    end
  end

  describe "#intelligence_attribute" do
    context "when @intelligence_attribute is set" do
      let(:eve_intelligence_attribute) { double }

      before { subject.instance_variable_set(:@intelligence_attribute, eve_intelligence_attribute) }

      specify { expect(subject.intelligence_attribute).to eq(eve_intelligence_attribute) }
    end

    context "when @intelligence_attribute is not set" do
      let(:eve_intelligence_attribute) { instance_double(Eve::CharacterAttribute) }

      before do
        #
        # Eve::CharacterAttribute.find_by(attribute_name: "Intelligence") # => eve_intelligence_attribute
        #
        expect(Eve::CharacterAttribute).to receive(:find_by).with(attribute_name: "Intelligence").and_return(eve_intelligence_attribute)
      end

      let(:eve_intelligence_attribute_decorated) { double }

      before { expect(eve_intelligence_attribute).to receive(:decorate).and_return(eve_intelligence_attribute_decorated) }

      specify { expect(subject.intelligence_attribute).to eq(eve_intelligence_attribute_decorated) }
    end
  end

  describe "#memory_attribute" do
    context "when @memory_attribute is set" do
      let(:eve_memory_attribute) { double }

      before { subject.instance_variable_set(:@memory_attribute, eve_memory_attribute) }

      specify { expect(subject.memory_attribute).to eq(eve_memory_attribute) }
    end

    context "when @memory_attribute is not set" do
      let(:eve_memory_attribute) { instance_double(Eve::CharacterAttribute) }

      before do
        #
        # Eve::CharacterAttribute.find_by(attribute_name: "Memory") # => eve_memory_attribute
        #
        expect(Eve::CharacterAttribute).to receive(:find_by).with(attribute_name: "Memory").and_return(eve_memory_attribute)
      end

      let(:eve_memory_attribute_decorated) { double }

      before { expect(eve_memory_attribute).to receive(:decorate).and_return(eve_memory_attribute_decorated) }

      specify { expect(subject.memory_attribute).to eq(eve_memory_attribute_decorated) }
    end
  end

  describe "#perception_attribute" do
    context "when @perception_attribute is set" do
      let(:eve_perception_attribute) { double }

      before { subject.instance_variable_set(:@perception_attribute, eve_perception_attribute) }

      specify { expect(subject.perception_attribute).to eq(eve_perception_attribute) }
    end

    context "when @perception_attribute is not set" do
      let(:eve_perception_attribute) { instance_double(Eve::CharacterAttribute) }

      before do
        #
        # Eve::CharacterAttribute.find_by(attribute_name: "Perception") # => eve_perception_attribute
        #
        expect(Eve::CharacterAttribute).to receive(:find_by).with(attribute_name: "Perception").and_return(eve_perception_attribute)
      end

      let(:eve_perception_attribute_decorated) { double }

      before { expect(eve_perception_attribute).to receive(:decorate).and_return(eve_perception_attribute_decorated) }

      specify { expect(subject.perception_attribute).to eq(eve_perception_attribute_decorated) }
    end
  end

  describe "#willpower_attribute" do
    context "when @willpower_attribute is set" do
      let(:eve_willpower_attribute) { double }

      before { subject.instance_variable_set(:@willpower_attribute, eve_willpower_attribute) }

      specify { expect(subject.willpower_attribute).to eq(eve_willpower_attribute) }
    end

    context "when @willpower_attribute is not set" do
      let(:eve_willpower_attribute) { instance_double(Eve::CharacterAttribute) }

      before do
        #
        # Eve::CharacterAttribute.find_by(attribute_name: "Willpower") # => eve_willpower_attribute
        #
        expect(Eve::CharacterAttribute).to receive(:find_by).with(attribute_name: "Willpower").and_return(eve_willpower_attribute)
      end

      let(:eve_willpower_attribute_decorated) { double }

      before { expect(eve_willpower_attribute).to receive(:decorate).and_return(eve_willpower_attribute_decorated) }

      specify { expect(subject.willpower_attribute).to eq(eve_willpower_attribute_decorated) }
    end
  end

  describe "#token_expired?" do
    context "when expired" do
      subject { build(:character, token_expires_at: Time.zone.now - 1.hour) }

      specify { expect(subject.token_expired?).to eq(true) }
    end

    context "when not expired" do
      subject { build(:character, token_expires_at: Time.zone.now + 1.hour) }

      specify { expect(subject.token_expired?).to eq(false) }
    end
  end
end
