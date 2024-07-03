# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::CorporationsController do
  describe "routing" do
    it "should route GET /universe/corporations to universe/corporations#index" do
      expect(get: "/universe/corporations").to route_to(
        controller: "universe/corporations",
        action: "index"
      )
    end

    it "should route GET /universe/corporations/:id to universe/corporations#show" do
      expect(get: "/universe/corporations/98005120").to route_to(
        controller: "universe/corporations",
        action: "show",
        id: "98005120"
      )
    end
  end
end
