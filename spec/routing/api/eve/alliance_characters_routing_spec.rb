# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::AllianceCharactersController do
  describe "routing" do
    it "should route GET /api/eve/alliances/:alliance_id/characters to api/eve/alliance_characters#index" do
      expect(get: "/api/eve/alliances/12345/characters").to route_to(
        controller: "api/eve/alliance_characters",
        action: "index",
        alliance_id: "12345",
        format: "json"
      )
    end
  end
end
