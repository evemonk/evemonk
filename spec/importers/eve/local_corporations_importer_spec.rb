# frozen_string_literal: true

require "rails_helper"

describe Eve::LocalCorporationsImporter do
  describe "#import" do
    let(:id) { double }

    before do
      #
      # Eve::Corporation.ids # => [id]
      #
      expect(Eve::Corporation).to receive(:ids).and_return([id])
    end

    before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
