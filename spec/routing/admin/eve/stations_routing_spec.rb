# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::Eve::StationsController do
  describe "routing" do
    it "should route GET /admin/eve/stations to admin/eve/stations#index" do
      expect(get: "/admin/eve/stations").to route_to(
        controller: "admin/eve/stations",
        action: "index"
      )
    end

    it "should route GET /admin/eve/stations/:id to admin/eve/stations#show" do
      expect(get: "/admin/eve/stations/1").to route_to(
        controller: "admin/eve/stations",
        action: "show",
        id: "1"
      )
    end
  end
end
