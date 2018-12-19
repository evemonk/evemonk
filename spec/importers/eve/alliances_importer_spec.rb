# frozen_string_literal: true

require 'rails_helper'

describe Eve::AlliancesImporter do
  describe '#import' do
    let(:alliance_id) { double }

    let(:alliances) { instance_double(EveOnline::ESI::Alliances, alliance_ids: [alliance_id]) }

    before { expect(EveOnline::ESI::Alliances).to receive(:new).and_return(alliances) }

    before { expect(Eve::AllianceImporterWorker).to receive(:perform_async).with(alliance_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
