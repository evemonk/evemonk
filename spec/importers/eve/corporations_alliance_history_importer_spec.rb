# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::CorporationsAllianceHistoryImporter do
  describe "#import" do
    let(:corporation_id) { double }

    before do
      #
      # Eve::Corporation.pluck(:corporation_id) # => [corporation_id]
      #
      expect(Eve::Corporation).to receive(:pluck).with(:corporation_id).and_return([corporation_id])
    end

    before { expect(Eve::UpdateCorporationAllianceHistoryJob).to receive(:perform_later).with(corporation_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
