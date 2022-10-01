# frozen_string_literal: true

require "rails_helper"

describe Admin::Eve::AgentsController do
  describe "routing" do
    it "should route GET /admin/eve/agents to admin/eve/agents#index" do
      expect(get: "/admin/eve/agents").to route_to(
        controller: "admin/eve/agents",
        action: "index"
      )
    end

    it "should route GET /admin/eve/agents/:id to admin/eve/agents#show" do
      expect(get: "/admin/eve/agents/1").to route_to(
        controller: "admin/eve/agents",
        action: "show",
        id: "1"
      )
    end
  end
end
