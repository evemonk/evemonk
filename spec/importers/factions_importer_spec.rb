# frozen_string_literal: true

require 'rails_helper'

describe FactionsImporter do
  describe '#import' do
    let(:factions) { instance_double(EveOnline::ESI::Factions) }

    let(:faction) { instance_double(EveOnline::ESI::Models::Faction) }

    let(:json) { double }

    before { expect(EveOnline::ESI::Factions).to receive(:new).and_return(factions) }

    before { expect(factions).to receive(:factions).and_return([faction]) }

    before { expect(faction).to receive(:as_json).and_return(json) }

    before do
      #
      # Eve::Faction.create!(json)
      #
      expect(Eve::Faction).to receive(:create!).with(json)
    end

    specify { expect { subject.import }.not_to raise_error }
  end
end
