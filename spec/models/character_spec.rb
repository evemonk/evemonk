# frozen_string_literal: true

require "rails_helper"

describe Character do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { should belong_to(:user) }

  it { should belong_to(:race).class_name("Eve::Race").with_primary_key("race_id").optional(true) }

  it { should belong_to(:bloodline).class_name("Eve::Bloodline").with_primary_key("bloodline_id").optional(true) }

  it { should belong_to(:faction).class_name("Eve::Faction").with_primary_key("faction_id").optional(true) }

  it { should belong_to(:ancestry).class_name("Eve::Ancestry").with_primary_key("ancestry_id").optional(true) }

  it { should belong_to(:alliance).class_name("Eve::Alliance").with_primary_key("alliance_id").optional(true) }

  it { should belong_to(:corporation).class_name("Eve::Corporation").with_primary_key("corporation_id").optional(true) }

  it { should belong_to(:current_ship_type).class_name("Eve::Ship").with_primary_key("type_id").with_foreign_key("current_ship_type_id").optional(true) }

  it { should belong_to(:current_solar_system).class_name("Eve::System").with_primary_key("system_id").with_foreign_key("current_solar_system_id").optional(true) }

  it { should belong_to(:current_station).class_name("Eve::Station").with_primary_key("station_id").with_foreign_key("current_station_id").optional(true) }

  it { should have_many(:etags).dependent(:destroy) }

  it { should have_many(:loyalty_points).dependent(:destroy) }

  it { should have_many(:character_assets).dependent(:destroy) }

  it { should have_many(:character_implants).dependent(:destroy) }

  it { should have_many(:implants).through(:character_implants) }

  it { should have_many(:skillqueues).dependent(:destroy) }

  it { should have_many(:character_skills).dependent(:destroy) }

  it { should have_many(:character_corporation_histories).with_primary_key("character_id").dependent(:destroy) }

  it { should have_many(:character_mail_labels).dependent(:destroy) }

  it { should have_many(:standings).dependent(:destroy) }

  it { should have_many(:character_killmails).dependent(:destroy) }

  it { should have_many(:wallet_journals).dependent(:destroy) }

  it { should have_many(:wallet_transactions).dependent(:destroy) }

  it { should have_many(:character_blueprints).dependent(:destroy) }

  it { should have_many(:industry_jobs).dependent(:destroy) }

  it { should have_many(:character_orders).dependent(:destroy) }

  it { should have_many(:manufacturing_jobs).dependent(:destroy) }

  describe "#factions_standings" do
    let!(:character) { create(:character) }

    let!(:faction) { create(:eve_faction) }

    let!(:corporation) { create(:eve_corporation) }

    let!(:agent) { create(:eve_agent) }

    let!(:standing1) { create(:standing, character: character, standingable: faction) }

    let!(:standing2) { create(:standing, character: character, standingable: corporation) }

    let!(:standing3) { create(:standing, character: character, standingable: agent) }

    specify { expect(character.factions_standings.count).to eq(1) }

    specify { expect(character.factions_standings).to eq([standing1]) }
  end

  describe "#corporations_standings" do
    let!(:character) { create(:character) }

    let!(:faction) { create(:eve_faction) }

    let!(:corporation) { create(:eve_corporation) }

    let!(:agent) { create(:eve_agent) }

    let!(:standing1) { create(:standing, character: character, standingable: faction) }

    let!(:standing2) { create(:standing, character: character, standingable: corporation) }

    let!(:standing3) { create(:standing, character: character, standingable: agent) }

    specify { expect(character.corporations_standings.count).to eq(1) }

    specify { expect(character.corporations_standings).to eq([standing2]) }
  end

  describe "#agents_standings" do
    let!(:character) { create(:character) }

    let!(:faction) { create(:eve_faction) }

    let!(:corporation) { create(:eve_corporation) }

    let!(:agent) { create(:eve_agent) }

    let!(:standing1) { create(:standing, character: character, standingable: faction) }

    let!(:standing2) { create(:standing, character: character, standingable: corporation) }

    let!(:standing3) { create(:standing, character: character, standingable: agent) }

    specify { expect(character.agents_standings.count).to eq(1) }

    specify { expect(character.agents_standings).to eq([standing3]) }
  end

  describe ".with_valid_tokens" do
    let!(:character1) { create(:character, esi_token_valid: true) }

    let!(:character2) { create(:character, esi_token_valid: false) }

    specify { expect(described_class.with_valid_tokens).to eq([character1]) }
  end

  it { should delegate_method(:perception_without_bonuses).to(:character_attributes) }

  it { should delegate_method(:perception_bonus).to(:character_attributes) }

  it { should delegate_method(:memory_without_bonuses).to(:character_attributes) }

  it { should delegate_method(:memory_bonus).to(:character_attributes) }

  it { should delegate_method(:willpower_without_bonuses).to(:character_attributes) }

  it { should delegate_method(:willpower_bonus).to(:character_attributes) }

  it { should delegate_method(:intelligence_without_bonuses).to(:character_attributes) }

  it { should delegate_method(:intelligence_bonus).to(:character_attributes) }

  it { should delegate_method(:charisma_without_bonuses).to(:character_attributes) }

  it { should delegate_method(:charisma_bonus).to(:character_attributes) }

  it { should delegate_method(:science_skill).to(:character_skills_levels) }

  it { should delegate_method(:science_level).to(:character_skills_levels) }

  it { should delegate_method(:advanced_industry_skill).to(:character_skills_levels) }

  it { should delegate_method(:advanced_industry_level).to(:character_skills_levels) }

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
        # Eve::CharacterAttribute.find_by(name_en: "Perception") # => eve_perception_attribute
        #
        expect(Eve::CharacterAttribute).to receive(:find_by).with(name_en: "Perception").and_return(eve_perception_attribute)
      end

      let(:eve_perception_attribute_decorated) { double }

      before { expect(eve_perception_attribute).to receive(:decorate).and_return(eve_perception_attribute_decorated) }

      specify { expect(subject.perception_attribute).to eq(eve_perception_attribute_decorated) }
    end

    context "when character attribute not found" do
      specify { expect(subject.perception_attribute).to eq(nil) }
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
        # Eve::CharacterAttribute.find_by(name_en: "Memory") # => eve_memory_attribute
        #
        expect(Eve::CharacterAttribute).to receive(:find_by).with(name_en: "Memory").and_return(eve_memory_attribute)
      end

      let(:eve_memory_attribute_decorated) { double }

      before { expect(eve_memory_attribute).to receive(:decorate).and_return(eve_memory_attribute_decorated) }

      specify { expect(subject.memory_attribute).to eq(eve_memory_attribute_decorated) }
    end

    context "when character attribute not found" do
      specify { expect(subject.memory_attribute).to eq(nil) }
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
        # Eve::CharacterAttribute.find_by(name_en: "Willpower") # => eve_willpower_attribute
        #
        expect(Eve::CharacterAttribute).to receive(:find_by).with(name_en: "Willpower").and_return(eve_willpower_attribute)
      end

      let(:eve_willpower_attribute_decorated) { double }

      before { expect(eve_willpower_attribute).to receive(:decorate).and_return(eve_willpower_attribute_decorated) }

      specify { expect(subject.willpower_attribute).to eq(eve_willpower_attribute_decorated) }
    end

    context "when character attribute not found" do
      specify { expect(subject.willpower_attribute).to eq(nil) }
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
        # Eve::CharacterAttribute.find_by(name_en: "Intelligence") # => eve_intelligence_attribute
        #
        expect(Eve::CharacterAttribute).to receive(:find_by).with(name_en: "Intelligence").and_return(eve_intelligence_attribute)
      end

      let(:eve_intelligence_attribute_decorated) { double }

      before { expect(eve_intelligence_attribute).to receive(:decorate).and_return(eve_intelligence_attribute_decorated) }

      specify { expect(subject.intelligence_attribute).to eq(eve_intelligence_attribute_decorated) }
    end

    context "when character attribute not found" do
      specify { expect(subject.intelligence_attribute).to eq(nil) }
    end
  end

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
        # Eve::CharacterAttribute.find_by(name_en: "Charisma") # => eve_charisma_attribute
        #
        expect(Eve::CharacterAttribute).to receive(:find_by).with(name_en: "Charisma").and_return(eve_charisma_attribute)
      end

      let(:eve_charisma_attribute_decorated) { double }

      before { expect(eve_charisma_attribute).to receive(:decorate).and_return(eve_charisma_attribute_decorated) }

      specify { expect(subject.charisma_attribute).to eq(eve_charisma_attribute_decorated) }
    end

    context "when character attribute not found" do
      specify { expect(subject.charisma_attribute).to eq(nil) }
    end
  end

  describe "#skills_tree" do
    context "when @skills_tree is set" do
      let(:skills_tree) { instance_double(SkillsTree) }

      before { subject.instance_variable_set(:@skills_tree, skills_tree) }

      specify { expect(subject.skills_tree).to eq(skills_tree) }
    end

    context "when @skills_tree is not set" do
      let(:skills_tree) { instance_double(SkillsTree) }

      before { expect(SkillsTree).to receive(:new).with(subject).and_return(skills_tree) }

      specify { expect(subject.skills_tree).to eq(skills_tree) }

      specify { expect { subject.skills_tree }.to change { subject.instance_variable_get(:@skills_tree) }.from(nil).to(skills_tree) }
    end
  end

  describe "#character_skills_levels" do
    context "when @character_skills_levels is set" do
      let(:character_skills_levels) { instance_double(CharacterSkillsLevels) }

      before { subject.instance_variable_set(:@character_skills_levels, character_skills_levels) }

      specify { expect(subject.character_skills_levels).to eq(character_skills_levels) }
    end

    context "when @character_skills_levels is not set" do
      let(:character_skills_levels) { instance_double(CharacterSkillsLevels) }

      before { expect(CharacterSkillsLevels).to receive(:new).with(subject).and_return(character_skills_levels) }

      specify { expect(subject.character_skills_levels).to eq(character_skills_levels) }

      specify { expect { subject.character_skills_levels }.to change { subject.instance_variable_get(:@character_skills_levels) }.from(nil).to(character_skills_levels) }
    end
  end

  describe "#character_attributes" do
    context "when @character_attributes is set" do
      let(:character_attributes) { instance_double(CharacterAttributes) }

      before { subject.instance_variable_set(:@character_attributes, character_attributes) }

      specify { expect(subject.character_attributes).to eq(character_attributes) }
    end

    context "when @character_attributes is not set" do
      let(:character_attributes) { instance_double(CharacterAttributes) }

      before { expect(CharacterAttributes).to receive(:new).with(subject).and_return(character_attributes) }

      specify { expect(subject.character_attributes).to eq(character_attributes) }

      specify { expect { subject.character_attributes }.to change { subject.instance_variable_get(:@character_attributes) }.from(nil).to(character_attributes) }
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
