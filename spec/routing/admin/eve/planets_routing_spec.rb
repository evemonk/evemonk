# frozen_string_literal: true

require "rails_helper"

describe Admin::Eve::PlanetsController do
  describe "routing" do
    it "should route GET /admin/eve/planets to admin/eve/planets#index" do
      expect(get: "/admin/eve/planets").to route_to(
        controller: "admin/eve/planets",
        action: "index"
      )
    end

    it "should route GET /admin/eve/planets/:id to admin/eve/planets#show" do
      expect(get: "/admin/eve/planets/1").to route_to(
        controller: "admin/eve/planets",
        action: "show",
        id: "1"
      )
    end
  end
end
