# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::CorporationsController do
  describe "routing" do
    it "should route GET /api/eve/corporations to api/eve/corporations#index" do
      expect(get: "/api/eve/corporations").to route_to(
        controller: "api/eve/corporations",
        action: "index",
        format: "json"
      )
    end

    it "should route GET /api/eve/corporations/98005120 to api/eve/corporations#show" do
      expect(get: "/api/eve/corporations/98005120").to route_to(
        controller: "api/eve/corporations",
        action: "show",
        id: "98005120",
        format: "json"
      )
    end
  end
end
