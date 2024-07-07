# frozen_string_literal: true

require "rails_helper"

RSpec.describe StandingsController do
  describe "routing" do
    it "should route GET /characters/:character_id/standings to standings#index" do
      expect(get: "/characters/90729314/standings").to route_to(
        controller: "standings",
        action: "index",
        character_id: "90729314"
      )
    end
  end
end
