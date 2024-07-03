# frozen_string_literal: true

require "rails_helper"

RSpec.describe OrdersController do
  describe "routing" do
    it "should route GET /characters/:character_id/orders to orders#index" do
      expect(get: "/characters/90729314/orders").to route_to(
        controller: "orders",
        action: "index",
        character_id: "90729314"
      )
    end
  end
end
