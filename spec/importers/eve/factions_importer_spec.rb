# frozen_string_literal: true

require 'rails_helper'

describe Eve::FactionsImporter do
  describe '#import' do
    context 'when fresh data available' do
    end


    # let(:faction_id) { double }

    # let(:as_json) { double }

    # let(:faction) { instance_double(EveOnline::ESI::Models::Faction, faction_id: faction_id, as_json: as_json) }

    # let(:eveonline_factions) { instance_double(EveOnline::ESI::Factions, factions: [faction]) }

    # before { expect(EveOnline::ESI::Factions).to receive(:new).and_return(eveonline_factions) }

    # before { expect(Eve::Faction).to receive(:find_or_initialize_by).with(faction_id: faction_id).and_return(eve_faction) }

    # before { expect(eve_faction).to receive(:assign_attributes).with(as_json) }

    # context 'when faction changed' do
    #   let(:eve_faction) { instance_double(Eve::Faction, changed?: true) }

    #   before { expect(eve_faction).to receive(:save!) }

    #   specify { expect { subject.import }.not_to raise_error }
    # end

    # context 'when faction not changed' do
    #   let(:eve_faction) { instance_double(Eve::Faction, changed?: false) }

    #   before { expect(eve_faction).not_to receive(:save!) }

    #   specify { expect { subject.import }.not_to raise_error }
    # end
  end
end
