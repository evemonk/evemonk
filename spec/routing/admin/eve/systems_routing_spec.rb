# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::Eve::SystemsController do
  describe "routing" do
    it "should route GET /admin/eve/systems to admin/eve/systems#index" do
      expect(get: "/admin/eve/systems").to route_to(
        controller: "admin/eve/systems",
        action: "index"
      )
    end

    it "should route GET /admin/eve/systems/:id to admin/eve/systems#show" do
      expect(get: "/admin/eve/systems/1").to route_to(
        controller: "admin/eve/systems",
        action: "show",
        id: "1"
      )
    end
  end
end
