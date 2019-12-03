# frozen_string_literal: true

require "rails_helper"

describe CharacterLocationImporter do
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
          scopes: "esi-location.read_location.v1")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(4).times }

      let(:solar_system_id) { double }

      let(:station_id) { double }

      let(:structure_id) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterLocation,
          solar_system_id: solar_system_id,
          station_id: station_id,
          structure_id: structure_id,
          scope: "esi-location.read_location.v1")
      end

      before { expect(EveOnline::ESI::CharacterLocation).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

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
        instance_double(EveOnline::ESI::CharacterLocation,
          scope: "esi-location.read_location.v1")
      end

      before { expect(EveOnline::ESI::CharacterLocation).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

      before { expect(character).not_to receive(:update!) }

      specify { expect { subject.update! }.not_to raise_error }
    end
  end
end
