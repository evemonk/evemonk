# frozen_string_literal: true

require "rails_helper"

describe Admin::Eve::GraphicsController do
  describe "routing" do
    it "should route GET /admin/eve/graphics to admin/eve/graphics#index" do
      expect(get: "/admin/eve/graphics").to route_to(
        controller: "admin/eve/graphics",
        action: "index"
      )
    end

    it "should route GET /admin/eve/graphics/:id to admin/eve/graphics#show" do
      expect(get: "/admin/eve/graphics/1").to route_to(
        controller: "admin/eve/graphics",
        action: "show",
        id: "1"
      )
    end
  end
end
