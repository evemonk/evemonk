# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::Eve::AlliancesController do
  describe "routing" do
    it "should route GET /admin/eve/alliances to admin/eve/alliances#index" do
      expect(get: "/admin/eve/alliances").to route_to(
        controller: "admin/eve/alliances",
        action: "index"
      )
    end

    it "should route GET /admin/eve/alliances/:id to admin/eve/alliances#show" do
      expect(get: "/admin/eve/alliances/1").to route_to(
        controller: "admin/eve/alliances",
        action: "show",
        id: "1"
      )
    end
  end
end
