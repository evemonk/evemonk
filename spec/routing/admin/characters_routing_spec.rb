# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::CharactersController, type: :routing do
  describe "routing" do
    it "should route GET /admin/characters to admin/characters#index" do
      expect(get: "/admin/characters").to route_to(
        controller: "admin/characters",
        action: "index"
      )
    end

    it "should route GET /admin/characters/1 to admin/characters#show" do
      expect(get: "/admin/characters/1").to route_to(
        controller: "admin/characters",
        action: "show",
        id: "1"
      )
    end
  end
end
