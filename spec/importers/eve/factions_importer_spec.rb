# frozen_string_literal: true

require 'rails_helper'

describe Eve::FactionsImporter do
  describe '#import' do
    context 'when fresh data available' do
      let(:current_etag) { double }

      before do
        #
        # Redis.current.get("factions:#{ I18n.locale }:etag") # => current_etag
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:get).with("factions:#{ I18n.locale }:etag").and_return(current_etag)
          end
        end
      end

      let(:faction_id) { double }

      let(:as_json) { double }

      let(:faction) { instance_double(EveOnline::ESI::Models::Faction, faction_id: faction_id, as_json: as_json) }

      let(:eveonline_esi_factions) do
        instance_double(EveOnline::ESI::UniverseFactions,
                        not_modified?: false,
                        etag: new_etag,
                        factions: [faction])
      end

      let(:new_etag) { double }

      before { expect(EveOnline::ESI::UniverseFactions).to receive(:new).and_return(eveonline_esi_factions) }

      before { expect(Eve::Faction).to receive(:find_or_initialize_by).with(faction_id: faction_id).and_return(eve_faction) }

      before { expect(eve_faction).to receive(:assign_attributes).with(as_json) }

      before do
        #
        # Redis.current.set("factions:#{ I18n.locale }:etag", eveonline_esi_factions.etag)
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:set).with("factions:#{ I18n.locale }:etag", new_etag)
          end
        end
      end

      context 'when faction changed' do
        let(:eve_faction) { instance_double(Eve::Faction, changed?: true) }

        before { expect(eve_faction).to receive(:save!) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context 'when faction not changed' do
        let(:eve_faction) { instance_double(Eve::Faction, changed?: false) }

        before { expect(eve_faction).not_to receive(:save!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context 'when no fresh data available' do
      let(:current_etag) { double }

      before do
        #
        # Redis.current.get("factions:#{ I18n.locale }:etag") # => current_etag
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:get).with("factions:#{ I18n.locale }:etag").and_return(current_etag)
          end
        end
      end

      let(:eveonline_esi_factions) do
        instance_double(EveOnline::ESI::UniverseFactions,
                        not_modified?: true)
      end

      before { expect(EveOnline::ESI::UniverseFactions).to receive(:new).with(etag: current_etag).and_return(eveonline_esi_factions) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
