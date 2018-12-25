# frozen_string_literal: true

require 'rails_helper'

describe Eve::AncestriesImporter do
  describe '#import' do
    context 'when fresh data available' do
      let(:current_etag) { double }

      before do
        #
        # Redis.current.get("ancestries:#{ I18n.locale }:etag") # => current_etag
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:get).with("ancestries:#{ I18n.locale }:etag").and_return(current_etag)
          end
        end
      end

      let(:ancestry_id) { double }

      let(:as_json) { double }

      let(:ancestry) { instance_double(EveOnline::ESI::Models::Ancestry, ancestry_id: ancestry_id, as_json: as_json) }

      let(:eveonline_esi_ancestries) do
        instance_double(EveOnline::ESI::UniverseAncestries,
                        not_modified?: false,
                        etag: new_etag,
                        ancestries: [ancestry])
      end

      let(:new_etag) { double }

      before { expect(EveOnline::ESI::UniverseAncestries).to receive(:new).and_return(eveonline_esi_ancestries) }

      before { expect(Eve::Ancestry).to receive(:find_or_initialize_by).with(ancestry_id: ancestry_id).and_return(eve_ancestry) }

      before { expect(eve_ancestry).to receive(:assign_attributes).with(as_json) }

      before do
        #
        # Redis.current.set("ancestries:#{ I18n.locale }:etag", eveonline_esi_factions.etag)
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:set).with("ancestries:#{ I18n.locale }:etag", new_etag)
          end
        end
      end

      context 'when ancestry changed' do
        let(:eve_ancestry) { instance_double(Eve::Ancestry, changed?: true) }

        before { expect(eve_ancestry).to receive(:save!) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context 'when ancestry not changed' do
        let(:eve_ancestry) { instance_double(Eve::Ancestry, changed?: false) }

        before { expect(eve_ancestry).not_to receive(:save!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context 'when no fresh data available' do
      let(:current_etag) { double }

      before do
        #
        # Redis.current.get("ancestries:#{ I18n.locale }:etag") # => current_etag
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:get).with("ancestries:#{ I18n.locale }:etag").and_return(current_etag)
          end
        end
      end

      let(:eveonline_esi_ancestries) do
        instance_double(EveOnline::ESI::UniverseAncestries,
                        not_modified?: true)
      end

      before { expect(EveOnline::ESI::UniverseAncestries).to receive(:new).with(etag: current_etag).and_return(eveonline_esi_ancestries) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
