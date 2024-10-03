# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::AllRegionsContractsJob do
  it { is_expected.to be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    before do
      #
      # Eve::AllRegionsContractsImporter.new.import
      #
      expect(Eve::AllRegionsContractsImporter).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform }.not_to raise_error }
  end
end
