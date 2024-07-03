# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::Eve::CorporationsController do
  describe "routing" do
    it "should route GET /admin/eve/corporations to admin/eve/corporations#index" do
      expect(get: "/admin/eve/corporations").to route_to(
        controller: "admin/eve/corporations",
        action: "index"
      )
    end

    it "should route GET /admin/eve/corporations/:id to admin/eve/corporations#show" do
      expect(get: "/admin/eve/corporations/1").to route_to(
        controller: "admin/eve/corporations",
        action: "show",
        id: "1"
      )
    end
  end
end
