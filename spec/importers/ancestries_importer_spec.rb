# frozen_string_literal: true

require 'rails_helper'

describe AncestriesImporter do
  describe '#import' do
    let(:ancestries) { instance_double(EveOnline::ESI::Ancestries) }

    let(:ancestry) { instance_double(EveOnline::ESI::Models::Ancestry) }

    let(:eve_ancestry) { instance_double(Eve::Ancestry) }

    let(:ancestry_id) { double }

    let(:json) { double }

    before { expect(EveOnline::ESI::Ancestries).to receive(:new).and_return(ancestries) }

    before { expect(ancestries).to receive(:ancestries).and_return([ancestry]) }

    before { expect(ancestry).to receive(:ancestry_id).and_return(ancestry_id) }

    before do
      #
      # Eve::Ancestry.find_or_initialize_by(ancestry_id: ancestry.ancestry_id) => eve_ancestry
      #
      expect(Eve::Ancestry).to receive(:find_or_initialize_by).with(ancestry_id: ancestry_id).and_return(eve_ancestry)
    end

    before { expect(ancestry).to receive(:as_json).and_return(json) }

    before { expect(eve_ancestry).to receive(:update!).with(json) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
