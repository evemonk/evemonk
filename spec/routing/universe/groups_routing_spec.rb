# frozen_string_literal: true

require "rails_helper"

describe Universe::GroupsController do
  describe "routing" do
    it "should route GET /universe/groups/1 to universe/groups#show" do
      expect(get: "/universe/groups/1").to route_to(
        controller: "universe/groups",
        action: "show",
        id: "1"
      )
    end
  end
end
