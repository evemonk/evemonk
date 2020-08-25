# frozen_string_literal: true

require "rails_helper"

describe Admin::Eve::ConstellationsController do
  describe "routing" do
    it "should route GET /admin/eve/constellations to admin/eve/constellations#index" do
      expect(get: "/admin/eve/constellations").to route_to(
        controller: "admin/eve/constellations",
        action: "index"
      )
    end

    it "should route GET /admin/eve/constellations/1 to admin/eve/constellations#show" do
      expect(get: "/admin/eve/constellations/1").to route_to(
        controller: "admin/eve/constellations",
        action: "show",
        id: "1"
      )
    end
  end
end
