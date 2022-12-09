# frozen_string_literal: true

require "rails_helper"

describe Universe::Corporations::CharactersController do
  describe "routing" do
    it "should route GET /universe/corporations/:corporation_id/characters to universe/corporations/characters#index" do
      expect(get: "/universe/corporations/98005120/characters").to route_to(
        controller: "universe/corporations/characters",
        action: "index",
        corporation_id: "98005120"
      )
    end
  end
end
