# frozen_string_literal: true

require "rails_helper"

RSpec.describe SettingsController do
  describe "routing" do
    it "should route GET /characters/:character_id/settings to settings#index" do
      expect(get: "/characters/90729314/settings").to route_to(
        controller: "settings",
        action: "index",
        character_id: "90729314"
      )
    end
  end
end
