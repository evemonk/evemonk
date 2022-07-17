# frozen_string_literal: true

require "rails_helper"

describe Blueprints::SearchController do
  describe "routing" do
    it "should routes GET /blueprints to blueprints/search#index" do
      expect(get: "/blueprints").to route_to(
        controller: "blueprints/search",
        action: "index"
      )
    end

    it "should route GET /blueprints/search to blueprints/search#index" do
      expect(get: "/blueprints/search").to route_to(
        controller: "blueprints/search",
        action: "index"
      )
    end

    it "should route GET /blueprints/search/:id to blueprints/search#show" do
      expect(get: "/blueprints/search/24699").to route_to(
        controller: "blueprints/search",
        action: "show",
        id: "24699"
      )
    end
  end
end
