# frozen_string_literal: true

require 'rails_helper'

describe AlliancesImporter do
  describe '#import' do
    let(:alliances) { instance_double(EveOnline::ESI::Alliances) }

    let(:alliance) { instance_double(EveOnline::ESI::Alliance) }

    let(:alliance_icon) { instance_double(EveOnline::ESI::AllianceIcon) }

    let(:alliance_id) { double }

    let(:alliance_json) { double }

    let(:alliance_icon_json) { double }

    let(:alliance_with_icon) { double }

    let(:json) { double }

    before { expect(EveOnline::ESI::Alliances).to receive(:new).and_return(alliances) }

    before { expect(alliances).to receive(:alliances).and_return([alliance_id]) }

    before { expect(EveOnline::ESI::Alliance).to receive(:new).with(alliance_id: alliance_id).and_return(alliance) }

    before { expect(EveOnline::ESI::AllianceIcon).to receive(:new).with(alliance_id: alliance_id).and_return(alliance_icon) }

    before { expect(alliance).to receive(:as_json).and_return(alliance_json) }

    before { expect(alliance_icon).to receive(:as_json).and_return(alliance_icon_json) }

    before { expect(alliance_json).to receive(:merge).with(alliance_icon_json).and_return(alliance_with_icon) }

    before { expect(alliance_with_icon).to receive(:merge).with(alliance_id: alliance_id).and_return(json) }

    before do
      #
      # Eve::Alliance.create!(json)
      #
      expect(Eve::Alliance).to receive(:create!).with(json)
    end

    specify { expect { subject.import }.not_to raise_error }
  end
end
