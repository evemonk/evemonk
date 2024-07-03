# frozen_string_literal: true

require "rails_helper"

RSpec.describe Auth::EveOnlineSso::CallbacksController do
  describe "routing" do
    it "should route GET /auth/eve_online_sso/callback to auth/eve_online_sso/callbacks#show" do
      expect(get: "/auth/eve_online_sso/callback").to route_to(
        controller: "auth/eve_online_sso/callbacks",
        action: "show"
      )
    end
  end
end
