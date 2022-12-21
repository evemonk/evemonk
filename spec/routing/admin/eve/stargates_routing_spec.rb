# frozen_string_literal: true

require "rails_helper"

describe Admin::Eve::StargatesController do
  describe "routing" do
    it "should route GET /admin/eve/stargates to admin/eve/stargates#index" do
      expect(get: "/admin/eve/stargates").to route_to(
        controller: "admin/eve/stargates",
        action: "index"
      )
    end

    it "should route GET /admin/eve/stargates/:id to admin/eve/stargates#show" do
      expect(get: "/admin/eve/stargates/1").to route_to(
        controller: "admin/eve/stargates",
        action: "show",
        id: "1"
      )
    end
  end
end
