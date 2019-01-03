# frozen_string_literal: true

require 'rails_helper'

describe Eve::CorporationsImporter do
  describe '#import' do
    let(:corporation_id) { double }

    let(:corporations_ids) { [corporation_id] }

    before do
      #
      # Eve::AllianceCorporation.pluck(:corporation_id).uniq
      #
      expect(Eve::AllianceCorporation).to receive(:pluck).with(:corporation_id) do
        double.tap do |a|
          expect(a).to receive(:uniq).and_return(corporations_ids)
        end
      end
    end

    before { expect(Eve::CorporationImporterWorker).to receive(:perform_async).with(corporation_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
