# frozen_string_literal: true

require "rails_helper"

describe Blueprints::TimeEfficiencyController do
  describe "routing" do
    it "should route GET /blueprints/time_efficiency/:id to blueprints/time_efficiency#show" do
      expect(get: "/blueprints/time_efficiency/24699").to route_to(
        controller: "blueprints/time_efficiency",
        action: "show",
        id: "24699"
      )
    end
  end
end
