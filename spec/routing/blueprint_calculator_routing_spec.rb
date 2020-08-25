# frozen_string_literal: true

require "rails_helper"

describe BlueprintCalculatorController do
  describe "routing" do
    it "should route GET /blueprint_calculator to blueprint_calculator#index" do
      expect(get: "/blueprint_calculator").to route_to(
        controller: "blueprint_calculator",
        action: "index"
      )
    end

    it "should route GET /blueprint_calculator/:id to blueprint_calculator#show" do
      expect(get: "/blueprint_calculator/24699").to route_to(
        controller: "blueprint_calculator",
        action: "show",
        id: "24699"
      )
    end
  end
end
