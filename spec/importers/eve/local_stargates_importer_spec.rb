# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::LocalStargatesImporter do
  describe "#import" do
    let(:stargate_id) { double }

    before do
      #
      # Eve::Stargate.pluck(:stargate_id) => [stargate_id]
      #
      expect(Eve::Stargate).to receive(:pluck).with(:stargate_id).and_return([stargate_id])
    end

    before { expect(Eve::UpdateStargateJob).to receive(:perform_later).with(stargate_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
