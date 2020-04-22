# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::BlueprintsController do
  describe "routing" do
    it "should route GET /api/eve/blueprints to api/eve/blueprints#index" do
      expect(get: "/api/eve/blueprints").to route_to(
        controller: "api/eve/blueprints",
        action: "index",
        format: "json"
      )
    end
  end
end
