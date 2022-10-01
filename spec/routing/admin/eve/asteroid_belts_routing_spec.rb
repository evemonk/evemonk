# frozen_string_literal: true

require "rails_helper"

describe Admin::Eve::AsteroidBeltsController do
  describe "routing" do
    it "should route GET /admin/eve/asteroid_belts to admin/eve/asteroid_belts#index" do
      expect(get: "/admin/eve/asteroid_belts").to route_to(
        controller: "admin/eve/asteroid_belts",
        action: "index"
      )
    end

    it "should route GET /admin/eve/asteroid_belts/:id to admin/eve/asteroid_belts#show" do
      expect(get: "/admin/eve/asteroid_belts/1").to route_to(
        controller: "admin/eve/asteroid_belts",
        action: "show",
        id: "1"
      )
    end
  end
end
