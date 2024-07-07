# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::AlliancesController do
  describe "routing" do
    it "should route GET /universe/alliances to universe/alliances#index" do
      expect(get: "/universe/alliances").to route_to(
        controller: "universe/alliances",
        action: "index"
      )
    end

    it "should route GET /universe/alliances/:id to universe/alliances#show" do
      expect(get: "/universe/alliances/99005443").to route_to(
        controller: "universe/alliances",
        action: "show",
        id: "99005443"
      )
    end
  end
end
