# frozen_string_literal: true

require "rails_helper"

describe BlueprintsListsController do
  describe "routing" do
    it "should route GET /characters/:character_id/blueprints_lists to blueprints_lists#index" do
      expect(get: "/characters/90729314/blueprints_lists").to route_to(
        controller: "blueprints_lists",
        action: "index",
        character_id: "90729314"
      )
    end
  end
end
