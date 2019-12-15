# frozen_string_literal: true

require "rails_helper"

describe ChangePasswordsController do
  describe "routing" do
    it "should route GET /change_password to change_passwords#show" do
      expect(get: "/change_password").to route_to(
        controller: "change_passwords",
        action: "show"
      )
    end
  end
end
