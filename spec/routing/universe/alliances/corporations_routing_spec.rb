# frozen_string_literal: true

require "rails_helper"

describe Universe::Alliances::CorporationsController do
  describe "routing" do
    it "should route GET /universe/alliances/:alliance_id/corporations to universe/alliances/corporations#index" do
      expect(get: "/universe/alliances/99005443/corporations").to route_to(
        controller: "universe/alliances/corporations",
        action: "index",
        alliance_id: "99005443"
      )
    end
  end
end
