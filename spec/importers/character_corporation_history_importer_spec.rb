# frozen_string_literal: true

require "rails_helper"

describe CharacterCorporationHistoryImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#import!" do
    let(:character) { instance_double(Character) }

    before { expect(subject).to receive(:character).and_return(character) }

    let(:json) { double }

    let(:record_id) { double }

    let(:entry) { instance_double(EveOnline::ESI::Models::CharacterCorporationHistory, record_id: record_id, as_json: json) }

    let(:esi) do
      instance_double(EveOnline::ESI::CharacterCorporationHistory,
        entries: [entry])
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:character_corporation_history) { instance_double(CharacterCorporationHistory) }

    before do
      #
      # character.character_corporation_histories.find_or_initialize_by(record_id: entry.record_id)
      #
      expect(character).to receive(:character_corporation_histories) do
        double.tap do |a|
          expect(a).to receive(:find_or_initialize_by).with(record_id: record_id)
            .and_return(character_corporation_history)
        end
      end
    end

    before { expect(character_corporation_history).to receive(:update!).with(json) }

    specify { expect { subject.import! }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterCorporationHistory) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterCorporationHistory) }

      let(:character) { instance_double(Character, character_id: character_id) }

      before { expect(subject).to receive(:character).and_return(character) }

      before { expect(EveOnline::ESI::CharacterCorporationHistory).to receive(:new).with(character_id: character_id).and_return(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
