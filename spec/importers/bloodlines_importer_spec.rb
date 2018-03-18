# frozen_string_literal: true

require 'rails_helper'

describe BloodlinesImporter do
  describe '#import' do
    let(:bloodlines) { instance_double(EveOnline::ESI::Bloodlines) }

    let(:bloodline) { instance_double(EveOnline::ESI::Models::Bloodline) }

    let(:json) { double }

    before { expect(EveOnline::ESI::Bloodlines).to receive(:new).and_return(bloodlines) }

    before { expect(bloodlines).to receive(:bloodlines).and_return([bloodline]) }

    before { expect(bloodline).to receive(:as_json).and_return(json) }

    before do
      #
      # Eve::Bloodline.create!(json)
      #
      expect(Eve::Bloodline).to receive(:create!).with(json)
    end

    specify { expect { subject.import }.not_to raise_error }
  end
end
