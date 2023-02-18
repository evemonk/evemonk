# frozen_string_literal: true

require "rails_helper"

describe Blueprints::InventionsController do
  describe "routing" do
    it "should route GET /blueprints/inventions/:id to blueprints/inventions#show" do
      expect(get: "/blueprints/inventions/24699").to route_to(
        controller: "blueprints/inventions",
        action: "show",
        id: "24699"
      )
    end
  end
end
