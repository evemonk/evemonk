# frozen_string_literal: true

require "rails_helper"

describe Blueprints::SearchController do
  describe "routing" do
    it "should route POST /blueprints/search to blueprints/search#create" do
      expect(get: "/blueprints/search").to route_to(
        controller: "blueprints/search",
        action: "create"
      )
    end
  end
end
