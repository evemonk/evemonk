# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::Eve::CharactersController do
  describe "routing" do
    it "should route GET /admin/eve/characters to admin/eve/characters#index" do
      expect(get: "/admin/eve/characters").to route_to(
        controller: "admin/eve/characters",
        action: "index"
      )
    end

    it "should route GET /admin/eve/characters/:id to admin/eve/characters#show" do
      expect(get: "/admin/eve/characters/1").to route_to(
        controller: "admin/eve/characters",
        action: "show",
        id: "1"
      )
    end
  end
end
