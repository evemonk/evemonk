# frozen_string_literal: true

require "rails_helper"

describe EmailsController do
  describe "routing" do
    it "should route GET /characters/90729314/emails to emails#index" do
      expect(get: "/characters/90729314/emails").to route_to(
        controller: "emails",
        action: "index",
        character_id: "90729314"
      )
    end
  end
end
