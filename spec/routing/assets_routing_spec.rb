# frozen_string_literal: true

require "rails_helper"

RSpec.describe AssetsController do
  describe "routing" do
    it "should route GET /characters/:character_id/assets to assets#index" do
      expect(get: "/characters/90729314/assets").to route_to(
        controller: "assets",
        action: "index",
        character_id: "90729314"
      )
    end
  end
end
