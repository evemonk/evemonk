# frozen_string_literal: true

require "rails_helper"

describe CharacterSkillqueueImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#import!" do
    let(:character) { instance_double(Character) }

    before { expect(subject).to receive(:character).and_return(character).twice }

    let(:json) { double }

    let(:skill) { instance_double(EveOnline::ESI::Models::SkillQueueEntry, as_json: json) }

    let(:esi) do
      instance_double(EveOnline::ESI::CharacterSkillQueue,
        skills: [skill])
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

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

    specify { expect { subject.import! }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterSkillQueue) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterSkillQueue) }

      let(:character) { instance_double(Character, character_id: character_id) }

      before { expect(subject).to receive(:character).and_return(character) }

      before { expect(EveOnline::ESI::CharacterSkillQueue).to receive(:new).with({character_id: character_id}).and_return(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
