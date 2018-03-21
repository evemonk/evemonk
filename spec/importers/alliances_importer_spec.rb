# frozen_string_literal: true

require 'rails_helper'

describe AlliancesImporter do
  describe '#import' do
    let(:alliances) { instance_double(EveOnline::ESI::Alliances) }

    let(:alliance) { instance_double(EveOnline::ESI::Alliance) }

    let(:alliance_id) { double }

    let(:json) { double }

    before { expect(EveOnline::ESI::Alliances).to receive(:new).and_return(alliances) }

    before { expect(alliances).to receive(:alliances).and_return([alliance_id]) }

    before { expect(EveOnline::ESI::Alliance).to receive(:new).and_return(alliance) }

    before { expect(alliance).to receive(:as_json).and_return(json) }

    before do
      #
      # Eve::Alliance.create!(json)
      #
      expect(Eve::Alliance).to receive(:create!).with(json)
    end

    specify { expect { subject.import }.not_to raise_error }
  end
end
