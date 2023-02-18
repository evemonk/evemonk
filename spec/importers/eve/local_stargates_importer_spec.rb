# frozen_string_literal: true

require "rails_helper"

describe Eve::LocalStargatesImporter do
  describe "#import" do
    let(:stargate_id) { double }

    before do
      #
      # Eve::Stargate.pluck(:id) => [stargate_id]
      #
      expect(Eve::Stargate).to receive(:pluck).with(:id).and_return([stargate_id])
    end

    before { expect(Eve::UpdateStargateJob).to receive(:perform_later).with(stargate_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
