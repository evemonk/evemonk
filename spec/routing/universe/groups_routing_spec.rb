# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::GroupsController, type: :routing do
  describe "routing" do
    it "should route GET /universe/groups/:id to universe/groups#show" do
      expect(get: "/universe/groups/1").to route_to(
        controller: "universe/groups",
        action: "show",
        id: "1"
      )
    end
  end
end
