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
  end
end
