# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::Eve::RacesController do
  describe "routing" do
    it "should route GET /admin/eve/races to admin/eve/races#index" do
      expect(get: "/admin/eve/races").to route_to(
        controller: "admin/eve/races",
        action: "index"
      )
    end

    it "should route GET /admin/eve/races/:id to admin/eve/races#show" do
      expect(get: "/admin/eve/races/1").to route_to(
        controller: "admin/eve/races",
        action: "show",
        id: "1"
      )
    end
  end
end
