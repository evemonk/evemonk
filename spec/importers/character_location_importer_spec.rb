# frozen_string_literal: true

require "rails_helper"

describe CharacterLocationImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#import!" do
    let(:character) { instance_double(Character) }

    before { expect(subject).to receive(:character).and_return(character) }

    let(:solar_system_id) { double }

    let(:station_id) { double }

    let(:structure_id) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::CharacterLocation,
        solar_system_id: solar_system_id,
        station_id: station_id,
        structure_id: structure_id)
    end

    before { expect(subject).to receive(:esi).and_return(esi).exactly(3).times }

    before do
      #
      # character.update!(current_solar_system_id: esi.solar_system_id,
      #                   current_station_id: esi.station_id,
      #                   current_structure_id: esi.structure_id)
      #
      expect(character).to receive(:update!).with(current_solar_system_id: solar_system_id,
        current_station_id: station_id,
        current_structure_id: structure_id)
    end

    specify { expect { subject.import! }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterLocation) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterLocation) }

      let(:character) { instance_double(Character, character_id: character_id) }

      before { expect(subject).to receive(:character).and_return(character) }

      before { expect(EveOnline::ESI::CharacterLocation).to receive(:new).with(character_id: character_id).and_return(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
