# frozen_string_literal: true

require "rails_helper"

describe SignUpsController do
  describe "routing" do
    it "should route GET /sign_up to sign_ups#show" do
      expect(get: "/sign_up").to route_to(
        controller: "sign_ups",
        action: "show"
      )
    end

    it "should route POST /sign_up to sign_ups#create" do
      expect(post: "/sign_up").to route_to(
        controller: "sign_ups",
        action: "create"
      )
    end
  end
end
