# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::Eve::AncestriesController do
  describe "routing" do
    it "should route GET /admin/eve/ancestries to admin/eve/ancestries#index" do
      expect(get: "/admin/eve/ancestries").to route_to(
        controller: "admin/eve/ancestries",
        action: "index"
      )
    end

    it "should route GET /admin/eve/ancestries/:id to admin/eve/ancestries#show" do
      expect(get: "/admin/eve/ancestries/1").to route_to(
        controller: "admin/eve/ancestries",
        action: "show",
        id: "1"
      )
    end
  end
end
