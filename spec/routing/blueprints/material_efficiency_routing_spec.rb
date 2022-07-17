# frozen_string_literal: true

require "rails_helper"

describe Blueprints::MaterialEfficiencyController do
  describe "routing" do
    it "should route GET /blueprints/material_efficiency/:id to blueprints/material_efficiency#show" do
      expect(get: "/blueprints/material_efficiency/24699").to route_to(
        controller: "blueprints/material_efficiency",
        action: "show",
        id: "24699"
      )
    end
  end
end
