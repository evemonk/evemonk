# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::TypesController do
  describe "routing" do
    it "should route GET /api/eve/types to api/eve/types#index" do
      expect(get: "/api/eve/types").to route_to(
        controller: "api/eve/types",
        action: "index",
        format: "json"
      )
    end

    it "should route GET /api/eve/types/:id to api/eve/types#show" do
      expect(get: "/api/eve/types/23773").to route_to(
        controller: "api/eve/types",
        action: "show",
        id: "23773",
        format: "json"
      )
    end
  end
end
