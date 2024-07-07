# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::LocalMarketGroupsImporter do
  describe "#import" do
    let(:market_group_id) { double }

    before do
      #
      # Eve::MarketGroup.pluck(:market_group_id) => [market_group_id]
      #
      expect(Eve::MarketGroup).to receive(:pluck).with(:market_group_id).and_return([market_group_id])
    end

    before { expect(Eve::UpdateMarketGroupJob).to receive(:perform_later).with(market_group_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
