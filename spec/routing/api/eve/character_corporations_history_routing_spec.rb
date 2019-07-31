# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::CharacterCorporationsHistoryController do
  describe "routing" do
    it "should route GET /api/eve/characters/:character_id/corporations_history to api/eve/character_corporations_history#index" do
      expect(get: "/api/eve/characters/123/corporations_history").to route_to(
        controller: "api/eve/character_corporations_history",
        action: "index",
        format: "json",
        character_id: "123"
      )
    end
  end
end
