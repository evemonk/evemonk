# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::CorporationCharactersController do
  describe "routing" do
    it "should route GET /api/eve/corporations/:corporation_id/characters to api/eve/corporation_characters#index" do
      expect(get: "/api/eve/corporations/12345/characters").to route_to(
        controller: "api/eve/corporation_characters",
        action: "index",
        corporation_id: "12345",
        format: "json"
      )
    end
  end
end
