# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::UpdateMarketPricesJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("important") }

  describe "#perform" do
    before do
      #
      # Eve::MarketPricesImporter.new.import
      #
      expect(Eve::MarketPricesImporter).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform }.not_to raise_error }
  end
end
