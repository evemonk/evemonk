# frozen_string_literal: true

require "rails_helper"

describe Devise::PasswordsController do
  describe "routing" do
    it "should route GET /users/password/new to devise/passwords#new" do
      expect(get: "/users/password/new").to route_to(
        controller: "devise/passwords",
        action: "new"
      )
    end

    it "should route GET /users/password/edit to devise/passwords#edit" do
      expect(get: "/users/password/edit").to route_to(
        controller: "devise/passwords",
        action: "edit"
      )
    end

    it "should route PATCH /users/password to devise/passwords#update" do
      expect(patch: "/users/password").to route_to(
        controller: "devise/passwords",
        action: "update"
      )
    end

    it "should route PUT /users/password to devise/passwords#update" do
      expect(put: "/users/password").to route_to(
        controller: "devise/passwords",
        action: "update"
      )
    end

    it "should route POST /users/password to devise/passwords#create" do
      expect(post: "/users/password").to route_to(
        controller: "devise/passwords",
        action: "create"
      )
    end
  end
end
