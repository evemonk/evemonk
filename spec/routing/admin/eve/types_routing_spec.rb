# frozen_string_literal: true

require "rails_helper"

describe Admin::Eve::TypesController do
  describe "routing" do
    it "should route GET /admin/eve/types to admin/eve/types#index" do
      expect(get: "/admin/eve/types").to route_to(
        controller: "admin/eve/types",
        action: "index"
      )
    end

    it "should route GET /admin/eve/types/:id to admin/eve/types#show" do
      expect(get: "/admin/eve/types/1").to route_to(
        controller: "admin/eve/types",
        action: "show",
        id: "1"
      )
    end
  end
end
