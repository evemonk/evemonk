# frozen_string_literal: true

require "rails_helper"

describe SkillsController do
  describe "routing" do
    it "should route GET /characters/90729314/skills to skills#index" do
      expect(get: "/characters/90729314/skills").to route_to(
        controller: "skills",
        action: "index",
        character_id: "90729314"
      )
    end
  end
end
