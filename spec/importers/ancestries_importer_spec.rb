# frozen_string_literal: true

require 'rails_helper'

describe AncestriesImporter do
  describe '#import' do
    let(:ancestries) { instance_double(EveOnline::ESI::Ancestries) }

    let(:ancestry) { instance_double(EveOnline::ESI::Models::Ancestry) }

    let(:json) { double }

    before { expect(EveOnline::ESI::Ancestries).to receive(:new).and_return(ancestries) }

    before { expect(ancestries).to receive(:ancestries).and_return([ancestry]) }

    before { expect(ancestry).to receive(:as_json).and_return(json) }

    before do
      #
      # Eve::Ancestry.create!(json)
      #
      expect(Eve::Ancestry).to receive(:create!).with(json)
    end

    specify { expect { subject.import }.not_to raise_error }
  end
end
