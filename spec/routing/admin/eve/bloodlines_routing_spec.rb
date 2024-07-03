# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::Eve::BloodlinesController do
  describe "routing" do
    it "should route GET /admin/eve/bloodlines to admin/eve/bloodlines#index" do
      expect(get: "/admin/eve/bloodlines").to route_to(
        controller: "admin/eve/bloodlines",
        action: "index"
      )
    end

    it "should route GET /admin/eve/bloodlines/:id to admin/eve/bloodlines#show" do
      expect(get: "/admin/eve/bloodlines/1").to route_to(
        controller: "admin/eve/bloodlines",
        action: "show",
        id: "1"
      )
    end
  end
end
