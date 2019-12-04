# frozen_string_literal: true

require "rails_helper"

describe CharacterSkillsImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#update!" do
    context "when scope present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          access_token: access_token,
          scopes: "esi-skills.read_skills.v1")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(6).times }

      let(:total_sp) { double }

      let(:unallocated_sp) { double }

      let(:json) { double }

      let(:skill) { instance_double(EveOnline::ESI::Models::Skill, as_json: json) }

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterSkills,
          total_sp: total_sp,
          unallocated_sp: unallocated_sp,
          skills: [skill],
          scope: "esi-skills.read_skills.v1")
      end

      before { expect(EveOnline::ESI::CharacterSkills).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

      before { expect(character).to receive(:update!).with(total_sp: total_sp, unallocated_sp: unallocated_sp) }

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

      specify { expect { subject.update! }.not_to raise_error }
    end

    context "when scope not present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          access_token: access_token,
          scopes: "")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(3).times }

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterSkills,
          scope: "esi-skills.read_skills.v1")
      end

      before { expect(EveOnline::ESI::CharacterSkills).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

      before { expect(character).not_to receive(:update!) }

      before { expect(character).not_to receive(:character_skills) }

      specify { expect { subject.update! }.not_to raise_error }
    end
  end
end
