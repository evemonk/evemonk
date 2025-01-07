# frozen_string_literal: true

require "rails_helper"

RSpec.describe Blueprints::CalculatorController, type: :routing do
  describe "routing" do
    it "should route GET /blueprints/calculator to blueprints/calculator#index" do
      expect(get: "/blueprints/calculator").to route_to(
        controller: "blueprints/calculator",
        action: "index"
      )
    end

    it "should route GET /blueprints/calculator/:id to blueprints/calculator#show" do
      expect(get: "/blueprints/calculator/24699").to route_to(
        controller: "blueprints/calculator",
        action: "show",
        id: "24699"
      )
    end
  end
end
