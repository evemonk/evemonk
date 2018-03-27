# frozen_string_literal: true

require 'rails_helper'

describe FactionsImporter do
  describe '#import' do
    let(:factions) { instance_double(EveOnline::ESI::Factions) }

    let(:faction) { instance_double(EveOnline::ESI::Models::Faction) }

    let(:eve_faction) { instance_double(Eve::Faction) }

    let(:faction_id) { double }

    let(:json) { double }

    before { expect(EveOnline::ESI::Factions).to receive(:new).and_return(factions) }

    before { expect(factions).to receive(:factions).and_return([faction]) }

    before { expect(faction).to receive(:faction_id).and_return(faction_id) }

    before do
      #
      # Eve::Faction.find_or_initialize_by(faction_id: faction.faction_id) => eve_faction
      #
      expect(Eve::Faction).to receive(:find_or_initialize_by).with(faction_id: faction_id).and_return(eve_faction)
    end

    before { expect(faction).to receive(:as_json).and_return(json) }

    before { expect(eve_faction).to receive(:update!).with(json) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
