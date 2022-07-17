# frozen_string_literal: true

require "rails_helper"

describe Blueprints::ManufacturingController do
  describe "routing" do
    it "should route GET /blueprints/manufacturing/:id to blueprints/manufacturing#show" do
      expect(get: "/blueprints/manufacturing/24699").to route_to(
        controller: "blueprints/manufacturing",
        action: "show",
        id: "24699"
      )
    end
  end
end
