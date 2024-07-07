# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::Eve::UnitsController do
  describe "routing" do
    it "should route GET /admin/eve/units to admin/eve/units#index" do
      expect(get: "/admin/eve/units").to route_to(
        controller: "admin/eve/units",
        action: "index"
      )
    end

    it "should route GET /admin/eve/units/:id to admin/eve/units#show" do
      expect(get: "/admin/eve/units/1").to route_to(
        controller: "admin/eve/units",
        action: "show",
        id: "1"
      )
    end
  end
end
