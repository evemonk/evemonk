# frozen_string_literal: true

require "rails_helper"

describe TwoFactorsController do
  describe "routing" do
    it "should route GET /two_factor to two_factors#show" do
      expect(get: "/two_factor").to route_to(
        controller: "two_factors",
        action: "show"
      )
    end

    it "should route DELETE /two_factor to two_factors#destroy" do
      expect(delete: "/two_factor").to route_to(
        controller: "two_factors",
        action: "destroy"
      )
    end

    it "should route POST /two_factor to two_factors#create" do
      expect(post: "/two_factor").to route_to(
        controller: "two_factors",
        action: "create"
      )
    end
  end
end
