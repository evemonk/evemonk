# frozen_string_literal: true

require "rails_helper"

describe SkillqueuesController do
  describe "routing" do
    it "should route GET /characters/:character_id/skillqueues to skillqueues#index" do
      expect(get: "/characters/90729314/skillqueues").to route_to(
        controller: "skillqueues",
        action: "index",
        character_id: "90729314"
      )
    end
  end
end
