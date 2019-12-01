# frozen_string_literal: true

require "rails_helper"

describe CharacterLocationImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterAccessToken) }

  context "when character found" do
    let(:access_token) { double }

    let(:character) { instance_double(Character, access_token: access_token) }

    before { expect(Character).to receive(:find_by!).with(character_id: character_id).and_return(character) }

    before { expect(subject).to receive(:refresh_character_access_token) }

    let(:solar_system_id) { double }

    let(:station_id) { double }

    let(:structure_id) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::CharacterLocation,
        solar_system_id: solar_system_id,
        station_id: station_id,
        structure_id: structure_id)
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

    specify { expect { subject.import }.not_to raise_error }
  end

  context "when character not found (ActiveRecord::RecordNotFound)" do
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
