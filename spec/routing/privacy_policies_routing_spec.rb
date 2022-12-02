# frozen_string_literal: true

require "rails_helper"

describe PrivacyPoliciesController do
  describe "routing" do
    it "should route GET /privacy_policy to privacy_policies#show" do
      expect(get: "/privacy_policy").to route_to(
        controller: "privacy_policies",
        action: "show"
      )
    end
  end
end
