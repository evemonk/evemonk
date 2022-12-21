# frozen_string_literal: true

require "rails_helper"

describe Admin::Eve::MoonsController do
  describe "routing" do
    it "should route GET /admin/eve/moons to admin/eve/moons#index" do
      expect(get: "/admin/eve/moons").to route_to(
        controller: "admin/eve/moons",
        action: "index"
      )
    end

    it "should route GET /admin/eve/moons/:id to admin/eve/moons#show" do
      expect(get: "/admin/eve/moons/1").to route_to(
        controller: "admin/eve/moons",
        action: "show",
        id: "1"
      )
    end
  end
end
