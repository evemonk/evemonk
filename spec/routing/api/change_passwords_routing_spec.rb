# frozen_string_literal: true

require "rails_helper"

describe Api::ChangePasswordsController do
  describe "routing" do
    it "should route POST /api/change_password to api/change_passwords#create" do
      expect(post: "/api/change_password").to route_to(
        controller: "api/change_passwords",
        action: "create",
        format: "json"
      )
    end
  end
end
