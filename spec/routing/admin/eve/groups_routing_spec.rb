# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::Eve::GroupsController do
  describe "routing" do
    it "should route GET /admin/eve/groups to admin/eve/groups#index" do
      expect(get: "/admin/eve/groups").to route_to(
        controller: "admin/eve/groups",
        action: "index"
      )
    end

    it "should route GET /admin/eve/groups/:id to admin/eve/groups#show" do
      expect(get: "/admin/eve/groups/1").to route_to(
        controller: "admin/eve/groups",
        action: "show",
        id: "1"
      )
    end
  end
end
