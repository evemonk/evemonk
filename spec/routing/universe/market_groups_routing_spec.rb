# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::MarketGroupsController do
  describe "routing" do
    it "should route GET /universe/market_groups to universe/market_groups#index" do
      expect(get: "/universe/market_groups").to route_to(
        controller: "universe/market_groups",
        action: "index"
      )
    end

    it "should route GET /universe/market_groups/:id to universe/market_groups#show" do
      expect(get: "/universe/market_groups/1").to route_to(
        controller: "universe/market_groups",
        action: "show",
        id: "1"
      )
    end
  end
end
