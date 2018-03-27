# frozen_string_literal: true

require 'rails_helper'

describe BloodlinesImporter do
  describe '#import' do
    let(:bloodlines) { instance_double(EveOnline::ESI::Bloodlines) }

    let(:bloodline) { instance_double(EveOnline::ESI::Models::Bloodline) }

    let(:eve_bloodline) { instance_double(Eve::Bloodline) }

    let(:bloodline_id) { double }

    let(:json) { double }

    before { expect(EveOnline::ESI::Bloodlines).to receive(:new).and_return(bloodlines) }

    before { expect(bloodlines).to receive(:bloodlines).and_return([bloodline]) }

    before { expect(bloodline).to receive(:bloodline_id).and_return(bloodline_id) }

    before do
      #
      # Eve::Bloodline.find_or_initialize_by(bloodline_id: bloodline.bloodline_id)
      #
      expect(Eve::Bloodline).to receive(:find_or_initialize_by).with(bloodline_id: bloodline_id).and_return(eve_bloodline)
    end

    before { expect(bloodline).to receive(:as_json).and_return(json) }

    before { expect(eve_bloodline).to receive(:update!).with(json) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
