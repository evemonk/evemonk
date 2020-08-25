# frozen_string_literal: true

require "rails_helper"

describe Admin::Eve::MarketGroupsController do
  describe "routing" do
    it "should route GET /admin/eve/market_groups to admin/eve/market_groups#index" do
      expect(get: "/admin/eve/market_groups").to route_to(
        controller: "admin/eve/market_groups",
        action: "index"
      )
    end

    it "should route GET /admin/eve/market_groups/1 to admin/eve/market_groups#show" do
      expect(get: "/admin/eve/market_groups/1").to route_to(
        controller: "admin/eve/market_groups",
        action: "show",
        id: "1"
      )
    end
  end
end
