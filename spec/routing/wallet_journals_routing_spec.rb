# frozen_string_literal: true

require "rails_helper"

describe WalletJournalsController do
  describe "routing" do
    it "should route GET /characters/90729314/wallet_journals to wallet_journals#index" do
      expect(get: "/characters/90729314/wallet_journals").to route_to(
        controller: "wallet_journals",
        action: "index",
        character_id: "90729314"
      )
    end
  end
end
