# frozen_string_literal: true

require 'rails_helper'

describe Eve::RemoveOldAlliancesImporter do
  describe '#import' do
    context 'when fresh data available' do
      let(:current_etag) { double }

      before do
        #
        # Redis.current.get("remove_old_alliances:#{ I18n.locale }:etag") # => current_etag
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:get).with("remove_old_alliances:#{ I18n.locale }:etag").and_return(current_etag)
          end
        end
      end

      let(:alliance_id) { double }

      let(:alliance_ids) { [alliance_id] }

      let(:new_etag) { double }

      let(:eveonline_esi_alliances) do
        instance_double(EveOnline::ESI::Alliances,
                        not_modified?: false,
                        etag: new_etag,
                        alliance_ids: alliance_ids)
      end

      before { expect(EveOnline::ESI::Alliances).to receive(:new).and_return(eveonline_esi_alliances) }

      let(:eve_alliance_ids) { double }

      before { expect(Eve::Alliance).to receive(:pluck).with(:alliance_id).and_return(eve_alliance_ids) }

      let(:alliance_id_to_remove) { double }

      let(:alliance_ids_to_remove) { [alliance_id_to_remove] }

      before { expect(eve_alliance_ids).to receive(:-).with(alliance_ids).and_return(alliance_ids_to_remove) }

      let(:corporation_id) { double }

      let(:corporation) { instance_double(Eve::Corporation, corporation_id: corporation_id) }

      let(:corporations) { [corporation] }

      let(:eve_alliance) { instance_double(Eve::Alliance, corporations: corporations) }

      before { expect(Eve::Alliance).to receive(:find_or_initialize_by).with(alliance_id: alliance_id_to_remove).and_return(eve_alliance) }

      before do
        #
        # Eve::CorporationImporter.new(corporation.corporation_id).import
        #
        expect(Eve::CorporationImporter).to receive(:new).with(corporation_id) do
          double.tap do |a|
            expect(a).to receive(:import)
          end
        end
      end

      before { expect(eve_alliance).to receive(:destroy!) }

      before do
        #
        # Redis.current.set("remove_old_alliances:#{ I18n.locale }:etag", eveonline_esi_alliances.etag)
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:set).with("remove_old_alliances:#{ I18n.locale }:etag", new_etag)
          end
        end
      end

      specify { expect { subject.import }.not_to raise_error }
    end

    context 'when no fresh data available' do
      let(:etag) { double }

      before do
        #
        # Redis.current.get("remove_old_alliances:#{ I18n.locale }:etag") # => current_etag
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:get).with("remove_old_alliances:#{ I18n.locale }:etag").and_return(etag)
          end
        end
      end

      let(:eveonline_esi_alliances) do
        instance_double(EveOnline::ESI::Alliances,
                        not_modified?: true)
      end

      before { expect(EveOnline::ESI::Alliances).to receive(:new).with(etag: etag).and_return(eveonline_esi_alliances) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
