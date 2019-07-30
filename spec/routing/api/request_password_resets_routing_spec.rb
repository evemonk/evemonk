# frozen_string_literal: true

require "rails_helper"

describe Api::RequestPasswordResetsController do
  describe "routing" do
    it "should route POST /api/request_password_reset to api/request_password_resets#create" do
      expect(post: "/api/request_password_reset").to route_to(
        controller: "api/request_password_resets",
        action: "create",
        format: "json"
      )
    end
  end
end
