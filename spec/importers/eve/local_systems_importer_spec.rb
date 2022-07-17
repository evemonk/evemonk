# frozen_string_literal: true

require "rails_helper"

describe Eve::LocalSystemsImporter do
  describe "#import" do
    let(:system_id) { double }

    before do
      #
      # Eve::System.pluck(:id) => [system_id]
      #
      expect(Eve::System).to receive(:pluck).with(:id).and_return([system_id])
    end

    before { expect(Eve::UpdateSystemJob).to receive(:perform_later).with(system_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
