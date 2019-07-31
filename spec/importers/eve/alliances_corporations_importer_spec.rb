# frozen_string_literal: true

require "rails_helper"

describe Eve::AlliancesCorporationsImporter do
  describe "#import" do
    let(:alliance_id) { double }

    before do
      #
      # Eve::Alliance.pluck(:alliance_id) => [alliance_id]
      #
      expect(Eve::Alliance).to receive(:pluck).with(:alliance_id).and_return([alliance_id])
    end

    before { expect(Eve::AllianceCorporationsImporterWorker).to receive(:perform_async).with(alliance_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
