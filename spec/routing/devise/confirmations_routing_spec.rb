# frozen_string_literal: true

require "rails_helper"

describe Devise::ConfirmationsController do
  describe "routing" do
    it "should route GET /users/confirmation/new to devise/confirmations#new" do
      expect(get: "/users/confirmation/new").to route_to(
        controller: "devise/confirmations",
        action: "new"
      )
    end

    it "should route GET /users/confirmation to devise/confirmations#show" do
      expect(get: "/users/confirmation").to route_to(
        controller: "devise/confirmations",
        action: "show"
      )
    end

    it "should route POST /users/confirmation to devise/confirmations#create" do
      expect(post: "/users/confirmation").to route_to(
        controller: "devise/confirmations",
        action: "create"
      )
    end
  end
end
