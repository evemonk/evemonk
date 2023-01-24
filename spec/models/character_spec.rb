# frozen_string_literal: true

require "rails_helper"

describe Character do
  it { should be_an(ApplicationRecord) }

  it { should be_a(Imageable) }

  it { should respond_to(:versions) }

  it { should belong_to(:user) }

  it { should belong_to(:race).class_name("Eve::Race").optional(true) }

  it { should belong_to(:bloodline).class_name("Eve::Bloodline").optional(true) }

  it { should belong_to(:faction).class_name("Eve::Faction").optional(true) }

  it { should belong_to(:alliance).class_name("Eve::Alliance").optional(true) }

  it { should belong_to(:corporation).class_name("Eve::Corporation").optional(true) }

  it { should belong_to(:current_ship_type).class_name("Eve::Ship").optional(true) }

  it { should belong_to(:current_solar_system).class_name("Eve::System").optional(true) }

  it { should belong_to(:current_station).class_name("Eve::Station").optional(true) }

  it { should have_many(:character_scopes).dependent(:destroy) }

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

  it { should have_many(:notifications).dependent(:destroy) }

  describe ".with_valid_tokens" do
    let!(:character_1) { create(:character, esi_token_valid: true) }

    let!(:character_2) { create(:character, esi_token_valid: false) }

    specify { expect(described_class.with_valid_tokens).to eq([character_1]) }
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
      let(:eve_character_attribute) { double }

      before { subject.instance_variable_set(:@perception_attribute, eve_character_attribute) }

      specify { expect(subject.perception_attribute).to eq(eve_character_attribute) }
    end

    context "when @perception_attribute is not set" do
      let(:eve_character_attribute) { instance_double(Eve::CharacterAttribute) }

      before do
        #
        # Eve::CharacterAttribute.find_by(name_en: "Perception") # => eve_character_attribute
        #
        expect(Eve::CharacterAttribute).to receive(:find_by).with({name_en: "Perception"}).and_return(eve_character_attribute)
      end

      specify { expect(subject.perception_attribute).to eq(eve_character_attribute) }
    end

    context "when character attribute not found" do
      specify { expect(subject.perception_attribute).to eq(nil) }
    end
  end

  describe "#memory_attribute" do
    context "when @memory_attribute is set" do
      let(:eve_character_attribute) { double }

      before { subject.instance_variable_set(:@memory_attribute, eve_character_attribute) }

      specify { expect(subject.memory_attribute).to eq(eve_character_attribute) }
    end

    context "when @memory_attribute is not set" do
      let(:eve_character_attribute) { instance_double(Eve::CharacterAttribute) }

      before do
        #
        # Eve::CharacterAttribute.find_by(name_en: "Memory") # => eve_character_attribute
        #
        expect(Eve::CharacterAttribute).to receive(:find_by).with({name_en: "Memory"}).and_return(eve_character_attribute)
      end

      specify { expect(subject.memory_attribute).to eq(eve_character_attribute) }
    end

    context "when character attribute not found" do
      specify { expect(subject.memory_attribute).to eq(nil) }
    end
  end

  describe "#willpower_attribute" do
    context "when @willpower_attribute is set" do
      let(:eve_character_attribute) { double }

      before { subject.instance_variable_set(:@willpower_attribute, eve_character_attribute) }

      specify { expect(subject.willpower_attribute).to eq(eve_character_attribute) }
    end

    context "when @willpower_attribute is not set" do
      let(:eve_character_attribute) { instance_double(Eve::CharacterAttribute) }

      before do
        #
        # Eve::CharacterAttribute.find_by(name_en: "Willpower") # => eve_character_attribute
        #
        expect(Eve::CharacterAttribute).to receive(:find_by).with({name_en: "Willpower"}).and_return(eve_character_attribute)
      end

      specify { expect(subject.willpower_attribute).to eq(eve_character_attribute) }
    end

    context "when character attribute not found" do
      specify { expect(subject.willpower_attribute).to eq(nil) }
    end
  end

  describe "#intelligence_attribute" do
    context "when @intelligence_attribute is set" do
      let(:eve_character_attribute) { double }

      before { subject.instance_variable_set(:@intelligence_attribute, eve_character_attribute) }

      specify { expect(subject.intelligence_attribute).to eq(eve_character_attribute) }
    end

    context "when @intelligence_attribute is not set" do
      let(:eve_character_attribute) { instance_double(Eve::CharacterAttribute) }

      before do
        #
        # Eve::CharacterAttribute.find_by(name_en: "Intelligence") # => eve_character_attribute
        #
        expect(Eve::CharacterAttribute).to receive(:find_by).with({name_en: "Intelligence"}).and_return(eve_character_attribute)
      end

      specify { expect(subject.intelligence_attribute).to eq(eve_character_attribute) }
    end

    context "when character attribute not found" do
      specify { expect(subject.intelligence_attribute).to eq(nil) }
    end
  end

  describe "#charisma_attribute" do
    context "when @charisma_attribute is set" do
      let(:eve_character_attribute) { double }

      before { subject.instance_variable_set(:@charisma_attribute, eve_character_attribute) }

      specify { expect(subject.charisma_attribute).to eq(eve_character_attribute) }
    end

    context "when @charisma_attribute is not set" do
      let(:eve_character_attribute) { instance_double(Eve::CharacterAttribute) }

      before do
        #
        # Eve::CharacterAttribute.find_by(name_en: "Charisma") # => eve_character_attribute
        #
        expect(Eve::CharacterAttribute).to receive(:find_by).with({name_en: "Charisma"}).and_return(eve_character_attribute)
      end

      specify { expect(subject.charisma_attribute).to eq(eve_character_attribute) }
    end

    context "when character attribute not found" do
      specify { expect(subject.charisma_attribute).to eq(nil) }
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
      subject { build(:character, token_expires_at: 1.hour.ago) }

      specify { expect(subject.token_expired?).to eq(true) }
    end

    context "when not expired" do
      subject { build(:character, token_expires_at: 1.hour.from_now) }

      specify { expect(subject.token_expired?).to eq(false) }
    end
  end

  describe "#icon_tiny" do
    before { expect(subject).to receive(:character_portrait_url).with(32) }

    specify { expect { subject.icon_tiny }.not_to raise_error }
  end

  describe "#icon_small" do
    before { expect(subject).to receive(:character_portrait_url).with(64) }

    specify { expect { subject.icon_small }.not_to raise_error }
  end

  describe "#icon_medium" do
    before { expect(subject).to receive(:character_portrait_url).with(128) }

    specify { expect { subject.icon_medium }.not_to raise_error }
  end

  describe "#icon_large" do
    before { expect(subject).to receive(:character_portrait_url).with(256) }

    specify { expect { subject.icon_large }.not_to raise_error }
  end

  describe "#icon_huge" do
    before { expect(subject).to receive(:character_portrait_url).with(512) }

    specify { expect { subject.icon_huge }.not_to raise_error }
  end

  describe "#icon_gigantic" do
    before { expect(subject).to receive(:character_portrait_url).with(1024) }

    specify { expect { subject.icon_gigantic }.not_to raise_error }
  end

  describe "#wallet_formatted" do
    context "when wallet is empty" do
      subject do
        build(:character,
          wallet: nil)
      end

      specify { expect(subject.wallet_formatted).to eq("0") }
    end

    context "when wallet is present" do
      subject do
        build(:character,
          wallet: 8252.49)
      end

      specify { expect(subject.wallet_formatted).to eq("8 252") }
    end
  end

  describe "#total_sp_formatted" do
    subject do
      build(:character,
        total_sp: 50_362_576)
    end

    specify { expect(subject.total_sp_formatted).to eq("50 362 576") }
  end

  describe "#unallocated_sp_formatted" do
    subject do
      build(:character,
        unallocated_sp: 906_000)
    end

    specify { expect(subject.unallocated_sp_formatted).to eq("906 000") }
  end

  describe "#full_sp_formatted" do
    context "when unallocated_sp is nil" do
      subject do
        build(:character,
          total_sp: 50_362_576,
          unallocated_sp: nil)
      end

      specify { expect(subject.full_sp_formatted).to eq("50 362 576") }
    end

    context "when unallocated_sp is not nil" do
      subject do
        build(:character,
          total_sp: 50_362_576,
          unallocated_sp: 906_000)
      end

      specify { expect(subject.full_sp_formatted).to eq("51 268 576") }
    end
  end

  describe "#birthday_formatted" do
    context "when birthday is present" do
      subject do
        build(:character,
          birthday: "Sun, 03 May 2015 19:45:17 UTC +00:00")
      end

      specify { expect(subject.birthday_formatted).to eq("2015.05.03") }
    end

    context "when birthday is empty" do
      subject { build(:character, birthday: nil) }

      specify { expect(subject.birthday_formatted).to eq(nil) }
    end
  end

  describe "#sanitized_description" do
    subject do
      build(:character,
        description: "<b>Test</b>")
    end

    specify { expect(subject.sanitized_description).to eq("Test") }
  end

  describe "#rounded_security_status" do
    context "when security status is missing" do
      subject do
        build(:character,
          security_status: nil)
      end

      specify { expect(subject.rounded_security_status).to eq(nil) }
    end

    context "when security status is present" do
      subject do
        build(:character,
          security_status: 1.1234)
      end

      specify { expect(subject.rounded_security_status).to eq(1.1) }
    end
  end

  describe "#to_key" do
    context "when character_id is present" do
      subject { build(:character, character_id: 90_729_314) }

      specify { expect(subject.to_key).to eq([90_729_314]) }
    end

    context "when character_id is not present" do
      subject { build(:character, character_id: nil) }

      specify { expect(subject.to_key).to eq(nil) }
    end
  end

  describe "#to_param" do
    context "when character_id is present" do
      subject { build(:character, character_id: 90_729_314) }

      specify { expect(subject.to_param).to eq("90729314") }
    end

    context "when character_id is not present" do
      subject { build(:character, character_id: nil) }

      specify { expect(subject.to_param).to eq(nil) }
    end
  end

  # private methods

  describe "#character_portrait_url" do
    subject { build(:character, character_id: 90_729_314) }

    before do
      #
      # imageable_url("characters", character_id, "portrait", size)
      #
      expect(subject).to receive(:imageable_url).with("characters", 90_729_314, "portrait", 1024)
    end

    specify { expect { subject.send(:character_portrait_url, 1024) }.not_to raise_error }
  end
end
