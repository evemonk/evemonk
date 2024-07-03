# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::Eve::FactionsController do
  describe "routing" do
    it "should route GET /admin/eve/factions to admin/eve/factions#index" do
      expect(get: "/admin/eve/factions").to route_to(
        controller: "admin/eve/factions",
        action: "index"
      )
    end

    it "should route GET /admin/eve/factions/:id to admin/eve/factions#show" do
      expect(get: "/admin/eve/factions/1").to route_to(
        controller: "admin/eve/factions",
        action: "show",
        id: "1"
      )
    end
  end
end
