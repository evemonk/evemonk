# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::AllianceCorporationsController do
  describe "routing" do
    it "should route GET /api/eve/alliances/:alliance_id/corporations to api/eve/alliance_corporations#index" do
      expect(get: "/api/eve/alliances/12345/corporations").to route_to(
        controller: "api/eve/alliance_corporations",
        action: "index",
        alliance_id: "12345",
        format: "json"
      )
    end
  end
end
