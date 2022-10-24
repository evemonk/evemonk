# frozen_string_literal: true

require "rails_helper"

describe Eve::LocalAlliancesImporter do
  describe "#import" do
    let(:id) { double }

    before do
      #
      # Eve::Alliance.ids => [id]
      #
      expect(Eve::Alliance).to receive(:ids).and_return([id])
    end

    before { expect(Eve::UpdateAllianceJob).to receive(:perform_later).with(id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
