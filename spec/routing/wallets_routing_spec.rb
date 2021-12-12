# frozen_string_literal: true

require "rails_helper"

describe WalletsController do
  describe "routing" do
    it "should route PUT /characters/:character_id/wallet to wallets#update" do
      expect(put: "/characters/90729314/wallet").to route_to(
        controller: "wallets",
        action: "update",
        character_id: "90729314"
      )
    end

    it "should route PATCH /characters/:character_id/wallet to wallets#update" do
      expect(patch: "/characters/90729314/wallet").to route_to(
        controller: "wallets",
        action: "update",
        character_id: "90729314"
      )
    end
  end
end
