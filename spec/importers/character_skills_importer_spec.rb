# frozen_string_literal: true

require "rails_helper"

describe CharacterSkillsImporter do
  context "when character found" do
    let(:character_id) { double }

    subject { described_class.new(character_id) }

    let(:access_token) { double }

    let(:character) { instance_double(Character, access_token: access_token) }

    before { expect(Character).to receive(:find_by!).with(character_id: character_id).and_return(character) }

    let(:total_sp) { double }

    let(:unallocated_sp) { double }

    let(:json) { double }

    let(:skill) { instance_double(EveOnline::ESI::Models::Skill, as_json: json) }

    let(:esi) do
      instance_double(EveOnline::ESI::CharacterSkills,
        total_sp: total_sp,
        unallocated_sp: unallocated_sp,
        skills: [skill])
    end

    before { expect(EveOnline::ESI::CharacterSkills).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

    before { expect(character).to receive(:update!).with(total_sp: total_sp) }

    before { expect(character).to receive(:update!).with(unallocated_sp: unallocated_sp) }

    before do
      #
      # character.character_skills.destroy_all
      #
      expect(character).to receive(:character_skills) do
        double.tap do |a|
          expect(a).to receive(:destroy_all)
        end
      end
    end

    before do
      #
      # character.character_skills.create!(skill.as_json)
      #
      expect(character).to receive(:character_skills) do
        double.tap do |a|
          expect(a).to receive(:create!).with(json)
        end
      end
    end

    specify { expect { subject.import }.not_to raise_error }
  end

  context "when character not found (ActiveRecord::RecordNotFound)" do
    let(:character_id) { double }

    subject { described_class.new(character_id) }

    before { expect(Character).to receive(:find_by!).with(character_id: character_id).and_raise(ActiveRecord::RecordNotFound) }

    before do
      #
      # Rails.logger.info("Character with ID #{ character_id } not found")
      #
      expect(Rails).to receive(:logger) do
        double.tap do |a|
          expect(a).to receive(:info).with("Character with ID #{character_id} not found")
        end
      end
    end

    specify { expect { subject.import }.not_to raise_error }
  end
end
