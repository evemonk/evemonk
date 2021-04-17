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

  # def skills_count_in_group(group_id)
  #   skills_types.select { |type| type.group_id == group_id }.size
  # end
  #
  # def levels_trained_in_group(group_id)
  #   skill_ids = skills_types.select { |type| type.group_id == group_id }.map(&:type_id)
  #
  #   character_skills.select { |character_skill| skill_ids.include?(character_skill.skill_id) }.map(&:trained_skill_level).sum
  # end
  #
  # def total_levels_in_group(group_id)
  #   skills_types.select { |type| type.group_id == group_id }.size * 5
  # end
  #
  # def levels_in_training_queue(group_id)
  #   skill_ids = skills_types.select { |type| type.group_id == group_id }.map(&:type_id)
  #
  #   character_skillqueues.select { |skillqueue| skill_ids.include?(skillqueue.skill_id) }.size
  # end
  #
  # def current_skill_points_in_group(group_id)
  #   skill_ids = skills_types.select { |type| type.group_id == group_id }.map(&:type_id)
  #
  #   character_skills.select { |character_skill| skill_ids.include?(character_skill.skill_id) }.map(&:skillpoints_in_skill).sum
  # end
  #
  # def total_skill_points_in_group(group_id)
  #   0
  # end
  #
  # def certificates_claimed_in_group(group_id)
  #   0
  # end
  #
  # def total_certificates_in_group(group_id)
  #   certificates.select { |certificate| certificate.group_id == group_id }.size
  # end
  #
  # def skills_in_group(group_id)
  #   skills_types.select { |type| type.group_id == group_id }.sort_by(&:name_en)
  # end
  #
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
  end

  # def type_dogma_attributes
  #   @type_dogma_attributes ||= Eve::TypeDogmaAttribute.where(attribute_id: dogma_attributes.map(&:attribute_id).sort.uniq).to_a
  # end

  describe "#more_dogma_attributes" do
  end

  # def more_dogma_attributes
  #   @more_dogma_attributes ||= Eve::DogmaAttribute.published.where(attribute_id: type_dogma_attributes.map(&:value).map(&:to_i).sort.uniq).to_a
  # end
end
