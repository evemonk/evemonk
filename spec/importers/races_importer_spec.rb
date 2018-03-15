# frozen_string_literal: true

require 'rails_helper'

describe RacesImporter do
  describe '#import' do
    let(:races) { instance_double(EveOnline::ESI::Races) }

    let(:race) { instance_double(EveOnline::ESI::Models::Race) }

    let(:json) { double }

    before { expect(EveOnline::ESI::Races).to receive(:new).and_return(races) }

    before { expect(races).to receive(:races).and_return([race]) }

    before { expect(race).to receive(:as_json).and_return(json) }

    before do
      #
      # Eve::Race.create!(json)
      #
      expect(Eve::Race).to receive(:create!).with(json)
    end

    specify { expect { subject.import }.not_to raise_error }
  end
end
