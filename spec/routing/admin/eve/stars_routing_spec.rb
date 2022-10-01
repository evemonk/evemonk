# frozen_string_literal: true

require "rails_helper"

describe Admin::Eve::StarsController do
  describe "routing" do
    it "should route GET /admin/eve/stars to admin/eve/stars#index" do
      expect(get: "/admin/eve/stars").to route_to(
        controller: "admin/eve/stars",
        action: "index"
      )
    end

    it "should route GET /admin/eve/stars/:id to admin/eve/stars#show" do
      expect(get: "/admin/eve/stars/1").to route_to(
        controller: "admin/eve/stars",
        action: "show",
        id: "1"
      )
    end
  end
end
