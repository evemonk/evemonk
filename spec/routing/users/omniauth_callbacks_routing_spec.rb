# frozen_string_literal: true

require "rails_helper"

RSpec.describe Users::OmniauthCallbacksController, type: :routing do
  describe "routing" do
    it "should route POST /users/auth/eve_online_sso to users/omniauth_callbacks#passthru" do
      expect(post: "/users/auth/eve_online_sso").to route_to(
        controller: "users/omniauth_callbacks",
        action: "passthru"
      )
    end

    it "should route GET /users/auth/eve_online_sso/callback to users/omniauth_callbacks#eve_online_sso" do
      expect(get: "/users/auth/eve_online_sso/callback").to route_to(
        controller: "users/omniauth_callbacks",
        action: "eve_online_sso"
      )
    end

    it "should route POST /users/auth/eve_online_sso/callback to users/omniauth_callbacks#eve_online_sso" do
      expect(post: "/users/auth/eve_online_sso/callback").to route_to(
        controller: "users/omniauth_callbacks",
        action: "eve_online_sso"
      )
    end
  end
end
