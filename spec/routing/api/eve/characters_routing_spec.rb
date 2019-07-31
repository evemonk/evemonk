# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::CharactersController do
  describe "routing" do
    it "should route GET /api/eve/characters to api/eve/characters#index" do
      expect(get: "/api/eve/characters").to route_to(
        controller: "api/eve/characters",
        action: "index",
        format: "json"
      )
    end

    it "should route GET /api/eve/characters/90729314 to api/eve/characters#show" do
      expect(get: "/api/eve/characters/90729314").to route_to(
        controller: "api/eve/characters",
        action: "show",
        id: "90729314",
        format: "json"
      )
    end
  end
end
