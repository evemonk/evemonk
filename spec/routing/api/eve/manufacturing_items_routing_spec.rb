# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::Eve::ManufacturingItemsController do
  describe "routing" do
    it "should route GET /api/eve/manufacturing_items to api/eve/manufacturing_items#index" do
      expect(get: "/api/eve/manufacturing_items").to route_to(
        controller: "api/eve/manufacturing_items",
        action: "index",
        format: "json"
      )
    end
  end
end
