# frozen_string_literal: true

require "rails_helper"

describe Api::CharactersController do
  describe "routing" do
    it "should route GET /api/characters to api/characters#index" do
      expect(get: "/api/characters").to route_to(
        controller: "api/characters",
        action: "index",
        format: "json"
      )
    end

    it "should route GET /api/characters/:id to api/characters#show" do
      expect(get: "/api/characters/123").to route_to(
        controller: "api/characters",
        action: "show",
        id: "123",
        format: "json"
      )
    end

    it "should route DELETE /api/characters/:id to api/characters#destroy" do
      expect(delete: "/api/characters/123").to route_to(
        controller: "api/characters",
        action: "destroy",
        id: "123",
        format: "json"
      )
    end
  end
end
