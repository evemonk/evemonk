# frozen_string_literal: true

require 'rails_helper'

describe Eve::AlliancesImporter do
  describe '#import' do
    context 'when fresh data available' do
      let(:url) { double }

      let(:new_etag) { double }

      let(:alliance_id) { double }

      let(:eveonline_esi_alliances) do
        instance_double(EveOnline::ESI::Alliances,
                        not_modified?: false,
                        url: url,
                        etag: new_etag,
                        alliance_ids: [alliance_id])
      end

      before { expect(EveOnline::ESI::Alliances).to receive(:new).and_return(eveonline_esi_alliances) }

      let(:etag) { instance_double(Etag, etag: '97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a') }

      before { expect(Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(eveonline_esi_alliances).to receive(:etag=).with('97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a') }

      before { expect(Eve::AllianceImporterWorker).to receive(:perform_async).with(alliance_id) }

      before { expect(etag).to receive(:update!).with(etag: new_etag) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context 'when no fresh data available' do
      let(:url) { double }

      let(:eveonline_esi_alliances) do
        instance_double(EveOnline::ESI::Alliances,
                        not_modified?: true,
                        url: url)
      end

      before { expect(EveOnline::ESI::Alliances).to receive(:new).and_return(eveonline_esi_alliances) }

      let(:etag) { instance_double(Etag, etag: '97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a') }

      before { expect(Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(eveonline_esi_alliances).to receive(:etag=).with('97f0c48679f2b200043cdbc3406291fc945bcd652ddc7fc11ccdc37a') }

      before { expect(Eve::AllianceImporterWorker).not_to receive(:perform_async) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
