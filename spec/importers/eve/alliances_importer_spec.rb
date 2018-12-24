# frozen_string_literal: true

require 'rails_helper'

describe Eve::AlliancesImporter do
  describe '#import' do
    context 'when fresh data available' do
      let(:current_etag) { double }

      before do
        #
        # Redis.current.get("alliances:#{ I18n.locale }:etag") # => current_etag
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:get).with("alliances:#{ I18n.locale }:etag").and_return(current_etag)
          end
        end
      end

      let(:alliance_id) { double }

      let(:new_etag) { double }

      let(:eveonline_esi_alliances) do
        instance_double(EveOnline::ESI::Alliances,
                        not_modified?: false,
                        etag: new_etag,
                        alliance_ids: [alliance_id])
      end

      before { expect(EveOnline::ESI::Alliances).to receive(:new).with(etag: current_etag).and_return(eveonline_esi_alliances) }

      before { expect(Eve::AllianceImporterWorker).to receive(:perform_async).with(alliance_id) }

      before do
        #
        # Redis.current.set("alliances:#{ I18n.locale }:etag", eveonline_esi_alliances.etag)
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:set).with("alliances:#{ I18n.locale }:etag", new_etag)
          end
        end
      end

      specify { expect { subject.import }.not_to raise_error }
    end

    context 'when no fresh data available' do
      let(:current_etag) { double }

      before do
        #
        # Redis.current.get("alliances:#{ I18n.locale }:etag") # => current_etag
        #
        expect(Redis).to receive(:current) do
          double.tap do |a|
            expect(a).to receive(:get).with("alliances:#{ I18n.locale }:etag").and_return(current_etag)
          end
        end
      end

      let(:alliances) do
        instance_double(EveOnline::ESI::Alliances,
                        not_modified?: true)
      end

      before { expect(EveOnline::ESI::Alliances).to receive(:new).with(etag: current_etag).and_return(alliances) }

      before { expect(Eve::AllianceImporterWorker).not_to receive(:perform_async) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
