# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::CharactersController do
  describe "routing" do
    it "should route GET /universe/characters to universe/characters#index" do
      expect(get: "/universe/characters").to route_to(
        controller: "universe/characters",
        action: "index"
      )
    end

    it "should route GET /universe/characters/:id to universe/characters#show" do
      expect(get: "/universe/characters/90729314").to route_to(
        controller: "universe/characters",
        action: "show",
        id: "90729314"
      )
    end
  end
end
