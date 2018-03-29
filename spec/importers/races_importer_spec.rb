# frozen_string_literal: true

require 'rails_helper'

describe RacesImporter do
  describe '#import' do
    let(:races) { instance_double(EveOnline::ESI::Races) }

    let(:race) { instance_double(EveOnline::ESI::Models::Race) }

    let(:json) { double }

    let(:race_id) { double }

    let(:eve_race) { instance_double(Eve::Race) }

    before { expect(EveOnline::ESI::Races).to receive(:new).and_return(races) }

    before { expect(races).to receive(:races).and_return([race]) }

    before { expect(race).to receive(:race_id).and_return(race_id) }

    before { expect(race).to receive(:as_json).and_return(json) }

    before do
      #
      # Eve::Race.find_or_initialize_by(race_id: race.race_id)
      #
      expect(Eve::Race).to receive(:find_or_initialize_by).with(race_id: race_id).and_return(eve_race)
    end

    before { expect(eve_race).to receive(:update!).with(json) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
