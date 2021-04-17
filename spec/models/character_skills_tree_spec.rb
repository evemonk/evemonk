# frozen_string_literal: true

require "rails_helper"

describe CharacterSkillsTree do
  it { expect(described_class::SKILLS_CATEGORY_ID).to eq(16) }

  it { expect(described_class::PRIMARY_ATTRIBUTE_NAME).to eq("primaryAttribute") }

  it { expect(described_class::SECONDARY_ATTRIBUTE_NAME).to eq("secondaryAttribute") }

  let(:character) { instance_double(Character) }

  subject { described_class.new(character) }

  describe "#initialize" do
    its(:character) { should eq(character) }
  end

  describe "#preload" do
    before { expect(subject).to receive(:skill_category) }

    before { expect(subject).to receive(:skills_groups) }

    before { expect(subject).to receive(:skills_types) }

    before { expect(subject).to receive(:character_skills) }

    before { expect(subject).to receive(:character_skillqueues) }

    before { expect(subject).to receive(:certificates) }

    before { expect(subject).to receive(:dogma_attributes) }

    before { expect(subject).to receive(:type_dogma_attributes) }

    before { expect(subject).to receive(:more_dogma_attributes) }

    specify { expect(subject.preload).to eq(subject) }
  end

  describe "#skills_groups" do
    context "when @skills_groups is set" do
      let(:skills_groups) { double }

      before { subject.instance_variable_set(:@skills_groups, skills_groups) }

      specify { expect(subject.skills_groups).to eq(skills_groups) }
    end

    context "when @skills_groups is not set" do
      let(:category_id) { double }

      let(:skill_category) { instance_double(Eve::Category, category_id: category_id) }

      let(:skills_groups) { double }

      before { expect(subject).to receive(:skill_category).and_return(skill_category) }

      before do
        #
        # Eve::Group.published
        #           .where(category_id: skill_category.category_id)
        #           .order(:name_en)
        #           .to_a # => skills_groups
        #
        expect(Eve::Group).to receive(:published) do
          double.tap do |a|
            expect(a).to receive(:where).with(category_id: category_id) do
              double.tap do |b|
                expect(b).to receive(:order).with(:name_en) do
                  double.tap do |c|
                    expect(c).to receive(:to_a).and_return(skills_groups)
                  end
                end
              end
            end
          end
        end
      end

      specify { expect(subject.skills_groups).to eq(skills_groups) }

      specify { expect { subject.skills_groups }.to change { subject.instance_variable_get(:@skills_groups) }.from(nil).to(skills_groups) }
    end
  end

  describe "#skills_count_in_group" do
    let(:skill_type1) { instance_double(Eve::Type, group_id: 1) }

    let(:skill_type2) { instance_double(Eve::Type, group_id: 1) }

    let(:skill_type3) { instance_double(Eve::Type, group_id: 2) }

    let(:skill_type4) { instance_double(Eve::Type, group_id: 2) }

    let(:skill_type5) { instance_double(Eve::Type, group_id: 2) }

    let(:skills_types) { [skill_type1, skill_type2, skill_type3, skill_type4, skill_type5] }

    before { expect(subject).to receive(:skills_types).and_return(skills_types) }

    specify { expect(subject.skills_count_in_group(1)).to eq(2) }

    specify { expect(subject.skills_count_in_group(2)).to eq(3) }

    specify { expect(subject.skills_count_in_group(3)).to eq(0) }
  end

  describe "#levels_trained_in_group" do
    let(:skill_type1) { instance_double(Eve::Type, type_id: 123, group_id: 1) }

    let(:skill_type2) { instance_double(Eve::Type, type_id: 124, group_id: 1) }

    let(:skill_type3) { instance_double(Eve::Type, type_id: 125, group_id: 2) }

    let(:skill_type4) { instance_double(Eve::Type, type_id: 126, group_id: 2) }

    let(:skill_type5) { instance_double(Eve::Type, type_id: 127, group_id: 2) }

    let(:skills_types) { [skill_type1, skill_type2, skill_type3, skill_type4, skill_type5] }

    before { expect(subject).to receive(:skills_types).and_return(skills_types) }

    let(:character_skill1) { instance_double(CharacterSkill, skill_id: 123, trained_skill_level: 5) }

    let(:character_skill2) { instance_double(CharacterSkill, skill_id: 124, trained_skill_level: 0) }

    let(:character_skill3) { instance_double(CharacterSkill, skill_id: 125, trained_skill_level: 4) }

    let(:character_skill4) { instance_double(CharacterSkill, skill_id: 126, trained_skill_level: 3) }

    let(:character_skill5) { instance_double(CharacterSkill, skill_id: 127, trained_skill_level: 2) }

    let(:character_skills) { [character_skill1, character_skill2, character_skill3, character_skill4, character_skill5] }

    before { expect(subject).to receive(:character_skills).and_return(character_skills) }

    specify { expect(subject.levels_trained_in_group(1)).to eq(5) }

    specify { expect(subject.levels_trained_in_group(2)).to eq(9) }

    specify { expect(subject.levels_trained_in_group(3)).to eq(0) }
  end

  describe "#total_levels_in_group" do
    let(:skill_type1) { instance_double(Eve::Type, group_id: 1) }

    let(:skill_type2) { instance_double(Eve::Type, group_id: 1) }

    let(:skill_type3) { instance_double(Eve::Type, group_id: 2) }

    let(:skill_type4) { instance_double(Eve::Type, group_id: 2) }

    let(:skill_type5) { instance_double(Eve::Type, group_id: 2) }

    let(:skills_types) { [skill_type1, skill_type2, skill_type3, skill_type4, skill_type5] }

    before { expect(subject).to receive(:skills_types).and_return(skills_types) }

    specify { expect(subject.total_levels_in_group(1)).to eq(10) }

    specify { expect(subject.total_levels_in_group(2)).to eq(15) }

    specify { expect(subject.total_levels_in_group(0)).to eq(0) }
  end

  describe "#levels_in_training_queue" do
    let(:skill_type1) { instance_double(Eve::Type, type_id: 123, group_id: 1) }

    let(:skill_type2) { instance_double(Eve::Type, type_id: 124, group_id: 1) }

    let(:skill_type3) { instance_double(Eve::Type, type_id: 125, group_id: 2) }

    let(:skill_type4) { instance_double(Eve::Type, type_id: 126, group_id: 2) }

    let(:skill_type5) { instance_double(Eve::Type, type_id: 127, group_id: 2) }

    let(:skills_types) { [skill_type1, skill_type2, skill_type3, skill_type4, skill_type5] }

    before { expect(subject).to receive(:skills_types).and_return(skills_types) }

    let(:skillqueue1) { instance_double(Skillqueue, skill_id: 123, finished_level: 1) }

    let(:skillqueue2) { instance_double(Skillqueue, skill_id: 123, finished_level: 2)  }

    let(:skillqueue3) { instance_double(Skillqueue, skill_id: 123, finished_level: 3)  }

    let(:skillqueue4) { instance_double(Skillqueue, skill_id: 123, finished_level: 4)  }

    let(:skillqueue5) { instance_double(Skillqueue, skill_id: 123, finished_level: 5)  }

    let(:character_skillqueues) { [skillqueue1, skillqueue2, skillqueue3, skillqueue4, skillqueue5] }

    before { expect(subject).to receive(:character_skillqueues).and_return(character_skillqueues) }

    specify { expect(subject.levels_in_training_queue(1)).to eq(5) }

    specify { expect(subject.levels_in_training_queue(2)).to eq(0) }

    specify { expect(subject.levels_in_training_queue(0)).to eq(0) }
  end

  describe "#current_skill_points_in_group" do
    let(:skill_type1) { instance_double(Eve::Type, type_id: 123, group_id: 1) }

    let(:skill_type2) { instance_double(Eve::Type, type_id: 124, group_id: 1) }

    let(:skill_type3) { instance_double(Eve::Type, type_id: 125, group_id: 2) }

    let(:skill_type4) { instance_double(Eve::Type, type_id: 126, group_id: 2) }

    let(:skill_type5) { instance_double(Eve::Type, type_id: 127, group_id: 2) }

    let(:skills_types) { [skill_type1, skill_type2, skill_type3, skill_type4, skill_type5] }

    before { expect(subject).to receive(:skills_types).and_return(skills_types) }

    let(:character_skill1) { instance_double(CharacterSkill, skill_id: 123, skillpoints_in_skill: 512) }

    let(:character_skill2) { instance_double(CharacterSkill, skill_id: 125, skillpoints_in_skill: 512) }

    let(:character_skill3) { instance_double(CharacterSkill, skill_id: 126, skillpoints_in_skill: 512) }

    let(:character_skills) { [character_skill1, character_skill2, character_skill3] }

    before { expect(subject).to receive(:character_skills).and_return(character_skills) }

    specify { expect(subject.current_skill_points_in_group(1)).to eq(512) }

    specify { expect(subject.current_skill_points_in_group(2)).to eq(1024) }

    specify { expect(subject.current_skill_points_in_group(0)).to eq(0) }
  end

  # def current_skill_points_in_group(group_id)
  #   skill_ids = skills_types.select { |type| type.group_id == group_id }.map(&:type_id)
  #
  #   character_skills.select { |character_skill| skill_ids.include?(character_skill.skill_id) }.map(&:skillpoints_in_skill).sum
  # end

  describe "#total_skill_points_in_group" do
    specify { expect(subject.total_skill_points_in_group(0)).to eq(0) }
  end

  describe "#certificates_claimed_in_group" do
    specify { expect(subject.certificates_claimed_in_group(0)).to eq(0) }
  end

  describe "#total_certificates_in_group" do
    let(:certificate1) { instance_double(Eve::Certificate, group_id: 1) }

    let(:certificate2) { instance_double(Eve::Certificate, group_id: 1) }

    let(:certificate3) { instance_double(Eve::Certificate, group_id: 1) }

    let(:certificate4) { instance_double(Eve::Certificate, group_id: 2) }

    let(:certificate5) { instance_double(Eve::Certificate, group_id: 2) }

    let(:certificates) { [certificate1, certificate2, certificate3, certificate5, certificate5] }

    before { expect(subject).to receive(:certificates).and_return(certificates) }

    specify { expect(subject.total_certificates_in_group(1)).to eq(3) }

    specify { expect(subject.total_certificates_in_group(2)).to eq(2) }

    specify { expect(subject.total_certificates_in_group(0)).to eq(0) }
  end

  describe "#skills_in_group" do
    let(:skill_type1) { instance_double(Eve::Type, group_id: 1, name_en: "B") }

    let(:skill_type2) { instance_double(Eve::Type, group_id: 1, name_en: "A") }

    let(:skill_type3) { instance_double(Eve::Type, group_id: 2, name_en: "E") }

    let(:skill_type4) { instance_double(Eve::Type, group_id: 2, name_en: "D") }

    let(:skill_type5) { instance_double(Eve::Type, group_id: 2, name_en: "C") }

    let(:skills_types) { [skill_type1, skill_type2, skill_type3, skill_type4, skill_type5] }

    before { expect(subject).to receive(:skills_types).and_return(skills_types) }

    specify { expect(subject.skills_in_group(1)).to eq([skill_type2, skill_type1]) }

    specify { expect(subject.skills_in_group(2)).to eq([skill_type5, skill_type4, skill_type3]) }

    specify { expect(subject.skills_in_group(0)).to eq([]) }
  end

  describe "#training_rate_for_skill" do
    specify { expect(subject.training_rate_for_skill(0)).to eq("0.00") }
  end

  # def training_rate_for_skill(skill_id)
  #   primary_dogma_attribute = dogma_attributes.find { |dogma_attribute| dogma_attribute.name == PRIMARY_ATTRIBUTE_NAME }
  #   primary_attribute_id = type_dogma_attributes.find { |tda| tda.type_id == skill_id && tda.attribute_id == primary_dogma_attribute.attribute_id }.value.to_i
  #   primary_attribute = more_dogma_attributes.find { |dogma_attribute| dogma_attribute.attribute_id == primary_attribute_id }
  #
  #   secondary_dogma_attribute = dogma_attributes.find { |dogma_attribute| dogma_attribute.name == SECONDARY_ATTRIBUTE_NAME }
  #   secondary_attribute_id = type_dogma_attributes.find { |tda| tda.type_id == skill_id && tda.attribute_id == secondary_dogma_attribute.attribute_id }.value.to_i
  #   secondary_attribute = more_dogma_attributes.find { |dogma_attribute| dogma_attribute.attribute_id == secondary_attribute_id }
  #
  #   primary = character.send(:"#{primary_attribute.name}")
  #   secondary = character.send(:"#{secondary_attribute.name}")
  #
  #   rate = EveOnline::Formulas::TrainingRate.new(primary, secondary).rate
  #
  #   format("%0.2f", rate)
  # end

  # private methods

  describe "#skill_category" do
    context "when @skill_category is set" do
      let(:skill_category) { double }

      before { subject.instance_variable_set(:@skill_category, skill_category) }

      specify { expect(subject.send(:skill_category)).to eq(skill_category) }
    end

    context "when @skill_category is not set" do
      let(:skill_category) { double }

      before do
        #
        # Eve::Category.published
        #              .find_by!(category_id: SKILLS_CATEGORY_ID) # => skill_category
        #
        expect(Eve::Category).to receive(:published) do
          double.tap do |a|
            expect(a).to receive(:find_by!).with(category_id: described_class::SKILLS_CATEGORY_ID)
              .and_return(skill_category)
          end
        end
      end

      specify { expect(subject.send(:skill_category)).to eq(skill_category) }

      specify { expect { subject.send(:skill_category) }.to change { subject.instance_variable_get(:@skill_category) }.from(nil).to(skill_category) }
    end
  end

  describe "#skills_types" do
    context "when @skills_types is set" do
      let(:skills_types) { double }

      before { subject.instance_variable_set(:@skills_types, skills_types) }

      specify { expect(subject.send(:skills_types)).to eq(skills_types) }
    end

    context "when @skills_types is not set" do
      let(:skills_types) { double }

      let(:group1) { instance_double(Eve::Group, group_id: 123) }

      let(:group2) { instance_double(Eve::Group, group_id: 123) }

      let(:group3) { instance_double(Eve::Group, group_id: 124) }

      let(:group4) { instance_double(Eve::Group, group_id: 125) }

      let(:skills_groups) { [group1, group2, group3, group4] }

      before { expect(subject).to receive(:skills_groups).and_return(skills_groups) }

      before do
        #
        # Eve::Type.published
        #          .where(group_id: skills_groups.map(&:group_id).sort.uniq)
        #          .to_a # => skills_types
        #
        expect(Eve::Type).to receive(:published) do
          double.tap do |a|
            expect(a).to receive(:where).with(group_id: [123, 124, 125]) do
              double.tap do |b|
                expect(b).to receive(:to_a).and_return(skills_types)
              end
            end
          end
        end
      end

      specify { expect(subject.send(:skills_types)).to eq(skills_types) }

      specify { expect { subject.send(:skills_types) }.to change { subject.instance_variable_get(:@skills_types) }.from(nil).to(skills_types) }
    end
  end

  describe "#certificates" do
    context "when @certificates is set" do
      let(:certificates) { double }

      before { subject.instance_variable_set(:@certificates, certificates) }

      specify { expect(subject.send(:certificates)).to eq(certificates) }
    end

    context "when @certificates is not set" do
      let(:certificates) { double }

      before do
        #
        # Eve::Certificate.all.to_a # => certificates
        #
        expect(Eve::Certificate).to receive(:all) do
          double.tap do |a|
            expect(a).to receive(:to_a).and_return(certificates)
          end
        end
      end

      specify { expect(subject.send(:certificates)).to eq(certificates) }

      specify { expect { subject.send(:certificates) }.to change { subject.instance_variable_get(:@certificates) }.from(nil).to(certificates) }
    end
  end

  describe "#character_skills" do
    context "when @character_skills is set" do
      let(:character_skills) { double }

      before { subject.instance_variable_set(:@character_skills, character_skills) }

      specify { expect(subject.send(:character_skills)).to eq(character_skills) }
    end

    context "when @character_skills is not set" do
      let(:character_skills) { double }

      before do
        #
        # character.character_skills.to_a
        #
        expect(character).to receive(:character_skills) do
          double.tap do |a|
            expect(a).to receive(:to_a).and_return(character_skills)
          end
        end
      end

      specify { expect(subject.send(:character_skills)).to eq(character_skills) }

      specify { expect { subject.send(:character_skills) }.to change { subject.instance_variable_get(:@character_skills) }.from(nil).to(character_skills) }
    end
  end

  describe "#character_skillqueues" do
    context "when @character_skillqueues is set" do
      let(:character_skillqueues) { double }

      before { subject.instance_variable_set(:@character_skillqueues, character_skillqueues) }

      specify { expect(subject.send(:character_skillqueues)).to eq(character_skillqueues) }
    end

    context "when @character_skillqueues is not set" do
      let(:character_skillqueues) { double }

      before { travel_to Time.zone.now }

      after { travel_back }

      before do
        #
        # character.skillqueues
        #          .order(:queue_position)
        #          .where("skillqueues.finish_date > :now", now: Time.zone.now)
        #          .to_a # => character_skillqueues
        #
        expect(character).to receive(:skillqueues) do
          double.tap do |a|
            expect(a).to receive(:order).with(:queue_position) do
              double.tap do |b|
                expect(b).to receive(:where).with("skillqueues.finish_date > :now", now: Time.zone.now) do
                  double.tap do |c|
                    expect(c).to receive(:to_a).and_return(character_skillqueues)
                  end
                end
              end
            end
          end
        end
      end

      specify { expect(subject.send(:character_skillqueues)).to eq(character_skillqueues) }

      specify { expect { subject.send(:character_skillqueues) }.to change { subject.instance_variable_get(:@character_skillqueues) }.from(nil).to(character_skillqueues) }
    end
  end

  describe "#dogma_attributes" do
    context "when @dogma_attributes is set" do
      let(:dogma_attributes) { double }

      before { subject.instance_variable_set(:@dogma_attributes, dogma_attributes) }

      specify { expect(subject.send(:dogma_attributes)).to eq(dogma_attributes) }
    end

    context "when @dogma_attributes is not set" do
      let(:dogma_attributes) { double }

      before do
        #
        # Eve::DogmaAttribute.published
        #                    .where(name: [PRIMARY_ATTRIBUTE_NAME, SECONDARY_ATTRIBUTE_NAME])
        #                    .to_a # => dogma_attributes
        #
        expect(Eve::DogmaAttribute).to receive(:published) do
          double.tap do |a|
            expect(a).to receive(:where).with(name: [described_class::PRIMARY_ATTRIBUTE_NAME, described_class::SECONDARY_ATTRIBUTE_NAME]) do
              double.tap do |b|
                expect(b).to receive(:to_a).and_return(dogma_attributes)
              end
            end
          end
        end
      end

      specify { expect(subject.send(:dogma_attributes)).to eq(dogma_attributes) }

      specify { expect { subject.send(:dogma_attributes) }.to change { subject.instance_variable_get(:@dogma_attributes) }.from(nil).to(dogma_attributes) }
    end
  end

  describe "#type_dogma_attributes" do
    context "when @type_dogma_attributes is set" do
      let(:type_dogma_attributes) { double }

      before { subject.instance_variable_set(:@type_dogma_attributes, type_dogma_attributes) }

      specify { expect(subject.send(:type_dogma_attributes)).to eq(type_dogma_attributes) }
    end

    context "when @type_dogma_attributes is not set" do
      let(:type_dogma_attributes) { double }

      let(:dogma_attribute1) { instance_double(Eve::DogmaAttribute, attribute_id: 321) }

      let(:dogma_attribute2) { instance_double(Eve::DogmaAttribute, attribute_id: 123) }

      let(:dogma_attribute3) { instance_double(Eve::DogmaAttribute, attribute_id: 123) }

      let(:dogma_attributes) { [dogma_attribute1, dogma_attribute2, dogma_attribute3] }

      before { expect(subject).to receive(:dogma_attributes).and_return(dogma_attributes) }

      before do
        #
        # Eve::TypeDogmaAttribute.where(attribute_id: dogma_attributes.map(&:attribute_id).sort.uniq).to_a
        #
        expect(Eve::TypeDogmaAttribute).to receive(:where).with(attribute_id: [123, 321]) do
          double.tap do |a|
            expect(a).to receive(:to_a).and_return(type_dogma_attributes)
          end
        end
      end

      specify { expect(subject.send(:type_dogma_attributes)).to eq(type_dogma_attributes) }

      specify { expect { subject.send(:type_dogma_attributes) }.to change { subject.instance_variable_get(:@type_dogma_attributes) }.from(nil).to(type_dogma_attributes) }
    end
  end

  describe "#more_dogma_attributes" do
    context "when @more_dogma_attributes is set" do
      let(:more_dogma_attributes) { double }

      before { subject.instance_variable_set(:@more_dogma_attributes, more_dogma_attributes) }

      specify { expect(subject.send(:more_dogma_attributes)).to eq(more_dogma_attributes) }
    end

    context "when @more_dogma_attributes is not set" do
      let(:more_dogma_attributes) { double }

      let(:type_dogma_attribute1) { instance_double(Eve::TypeDogmaAttribute, value: "321") }

      let(:type_dogma_attribute2) { instance_double(Eve::TypeDogmaAttribute, value: "123") }

      let(:type_dogma_attribute3) { instance_double(Eve::TypeDogmaAttribute, value: "123") }

      let(:type_dogma_attributes) { [type_dogma_attribute1, type_dogma_attribute2, type_dogma_attribute3] }

      before { expect(subject).to receive(:type_dogma_attributes).and_return(type_dogma_attributes) }

      before do
        #
        # Eve::DogmaAttribute.published.where(attribute_id: type_dogma_attributes.map(&:value).map(&:to_i).sort.uniq).to_a
        #
        expect(Eve::DogmaAttribute).to receive(:published) do
          double.tap do |a|
            expect(a).to receive(:where).with(attribute_id: [123, 321]) do
              double.tap do |b|
                expect(b).to receive(:to_a).and_return(more_dogma_attributes)
              end
            end
          end
        end
      end

      specify { expect(subject.send(:more_dogma_attributes)).to eq(more_dogma_attributes) }

      specify { expect { subject.send(:more_dogma_attributes) }.to change { subject.instance_variable_get(:@more_dogma_attributes) }.from(nil).to(more_dogma_attributes) }
    end
  end
end
