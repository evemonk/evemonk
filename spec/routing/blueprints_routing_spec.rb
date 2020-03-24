# frozen_string_literal: true

require "rails_helper"

describe BlueprintsController do
  describe "routing" do
    it "should route GET /characters/90729314/blueprints to blueprints#index" do
      expect(get: "/characters/90729314/blueprints").to route_to(
        controller: "blueprints",
        action: "index",
        character_id: "90729314"
      )
    end
  end
end
