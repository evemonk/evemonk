# frozen_string_literal: true

require "rails_helper"

RSpec.describe SkillsController, type: :routing do
  describe "routing" do
    it "should route GET /characters/:character_id/skills to skills#index" do
      expect(get: "/characters/90729314/skills").to route_to(
        controller: "skills",
        action: "index",
        character_id: "90729314"
      )
    end
  end
end
