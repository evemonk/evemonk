# frozen_string_literal: true

require "rails_helper"

describe CharacterSkillqueueImporter do
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
          scopes: "esi-skills.read_skillqueue.v1")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(5).times }

      let(:json) { double }

      let(:skill) { instance_double(EveOnline::ESI::Models::SkillQueueEntry, as_json: json) }

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterSkillQueue,
          skills: [skill],
          scope: "esi-skills.read_skillqueue.v1")
      end

      before { expect(EveOnline::ESI::CharacterSkillQueue).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

      before do
        #
        # character.skillqueues.destroy_all
        #
        expect(character).to receive(:skillqueues) do
          double.tap do |a|
            expect(a).to receive(:destroy_all)
          end
        end
      end

      before do
        #
        # character.skillqueues.create!(skill.as_json)
        #
        expect(character).to receive(:skillqueues) do
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
        instance_double(EveOnline::ESI::CharacterSkillQueue,
          scope: "esi-skills.read_skillqueue.v1")
      end

      before { expect(EveOnline::ESI::CharacterSkillQueue).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

      before { expect(character).not_to receive(:skillqueues) }

      specify { expect { subject.update! }.not_to raise_error }
    end
  end
end
