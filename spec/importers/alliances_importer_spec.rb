# frozen_string_literal: true

require 'rails_helper'

describe AlliancesImporter do
  describe '#import' do
    let(:alliances) { instance_double(EveOnline::ESI::Alliances) }

    let(:alliance) { instance_double(EveOnline::ESI::Alliance) }

    let(:alliance_icon) { instance_double(EveOnline::ESI::AllianceIcon) }

    let(:eve_alliance) { instance_double(Eve::Alliance) }

    let(:alliance_id) { double }

    let(:alliance_json) { double }

    let(:alliance_icon_json) { double }

    before { expect(EveOnline::ESI::Alliances).to receive(:new).and_return(alliances) }

    before { expect(alliances).to receive(:alliances).and_return([alliance_id]) }

    before { expect(EveOnline::ESI::Alliance).to receive(:new).with(alliance_id: alliance_id).and_return(alliance) }

    before { expect(EveOnline::ESI::AllianceIcon).to receive(:new).with(alliance_id: alliance_id).and_return(alliance_icon) }

    before { expect(Eve::Alliance).to receive(:find_or_initialize_by).with(alliance_id: alliance_id).and_return(eve_alliance) }

    before { expect(alliance).to receive(:as_json).and_return(alliance_json) }

    before { expect(eve_alliance).to receive(:update!).with(alliance_json) }

    before { expect(alliance_icon).to receive(:as_json).and_return(alliance_icon_json) }

    before { expect(eve_alliance).to receive(:update!).with(alliance_icon_json) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
