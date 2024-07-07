# frozen_string_literal: true

require "rails_helper"

RSpec.describe LoyaltyPointsController do
  describe "routing" do
    it "should route GET /characters/:character_id/loyalty_points to loyalty_points#index" do
      expect(get: "/characters/90729314/loyalty_points").to route_to(
        controller: "loyalty_points",
        action: "index",
        character_id: "90729314"
      )
    end
  end
end
