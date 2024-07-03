# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProfilesController do
  describe "routing" do
    it "should route GET /profile to profiles#show" do
      expect(get: "/profile").to route_to(
        controller: "profiles",
        action: "show"
      )
    end
  end
end
