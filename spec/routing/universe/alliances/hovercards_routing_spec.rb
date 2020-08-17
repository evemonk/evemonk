# frozen_string_literal: true

require "rails_helper"

describe Universe::Alliances::HovercardsController do
  describe "routing" do
    it "should route GET /universe/alliances/:alliance_id/hovercard to universe/alliances/hovercards#show" do
      expect(get: "/universe/alliances/99005443/hovercard").to route_to(
        controller: "universe/alliances/hovercards",
        action: "show",
        alliance_id: "99005443"
      )
    end
  end
end
