# frozen_string_literal: true

require "rails_helper"

describe Eve::UpdateMarketGroupsJob do
  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    before do
      #
      # Eve::MarketGroupsImporter.new.import
      #
      expect(Eve::MarketGroupsImporter).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    subject { described_class.new }

    specify { expect { subject.perform }.not_to raise_error }
  end
end
