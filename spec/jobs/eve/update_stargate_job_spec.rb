# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateStargateJob do
  it { is_expected.to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    let(:stargate_id) { double }

    before do
      #
      # Eve::StargateImporter.new(stargate_id).import
      #
      expect(Eve::StargateImporter).to receive(:new).with(stargate_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(stargate_id) }.not_to raise_error }
  end
end
