# frozen_string_literal: true

require "rails_helper"

describe Admin::Eve::RegionsController do
  describe "routing" do
    it "should route GET /admin/eve/regions to admin/eve/regions#index" do
      expect(get: "/admin/eve/regions").to route_to(
        controller: "admin/eve/regions",
        action: "index"
      )
    end

    it "should route GET /admin/eve/regions/:id to admin/eve/regions#show" do
      expect(get: "/admin/eve/regions/1").to route_to(
        controller: "admin/eve/regions",
        action: "show",
        id: "1"
      )
    end
  end
end
