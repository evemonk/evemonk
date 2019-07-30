# frozen_string_literal: true

require "rails_helper"

describe Api::ResetPasswordsController do
  describe "routing" do
    it "should route POST /api/reset_password to api/reset_passwords#create" do
      expect(post: "/api/reset_password").to route_to(
        controller: "api/reset_passwords",
        action: "create",
        format: "json"
      )
    end
  end
end
