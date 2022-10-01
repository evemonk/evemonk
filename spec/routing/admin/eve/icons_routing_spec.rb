# frozen_string_literal: true

require "rails_helper"

describe Admin::Eve::IconsController do
  describe "routing" do
    it "should route GET /admin/eve/icons to admin/eve/icons#index" do
      expect(get: "/admin/eve/icons").to route_to(
        controller: "admin/eve/icons",
        action: "index"
      )
    end

    it "should route GET /admin/eve/icons/:id to admin/eve/icons#show" do
      expect(get: "/admin/eve/icons/1").to route_to(
        controller: "admin/eve/icons",
        action: "show",
        id: "1"
      )
    end
  end
end
