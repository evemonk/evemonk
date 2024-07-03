# frozen_string_literal: true

require "rails_helper"

RSpec.describe AgentsController do
  describe "routing" do
    it "should route GET /characters/:character_id/agents to agents#index" do
      expect(get: "/characters/90729314/agents").to route_to(
        controller: "agents",
        action: "index",
        character_id: "90729314"
      )
    end
  end
end
