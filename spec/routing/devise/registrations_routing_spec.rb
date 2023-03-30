# frozen_string_literal: true

require "rails_helper"

describe Devise::RegistrationsController do
  describe "routing" do
    it "should route GET /users/cancel to devise/registrations#cancel" do
      expect(get: "/users/cancel").to route_to(
        controller: "devise/registrations",
        action: "cancel"
      )
    end

    it "should route GET /users/sign_up to devise/registrations#new" do
      expect(get: "/users/sign_up").to route_to(
        controller: "devise/registrations",
        action: "new"
      )
    end

    it "should route GET /users/edit to devise/registrations#edit" do
      expect(get: "/users/edit").to route_to(
        controller: "devise/registrations",
        action: "edit"
      )
    end

    it "should route PATCH /users to devise/registrations#update" do
      expect(patch: "/users").to route_to(
        controller: "devise/registrations",
        action: "update"
      )
    end

    it "should route PUT /users to devise/registrations#update" do
      expect(put: "/users").to route_to(
        controller: "devise/registrations",
        action: "update"
      )
    end

    it "should route DELETE /users to devise/registrations#destroy" do
      expect(delete: "/users").to route_to(
        controller: "devise/registrations",
        action: "destroy"
      )
    end

    it "should route POST /users to devise/registrations#create" do
      expect(post: "/users").to route_to(
        controller: "devise/registrations",
        action: "create"
      )
    end
  end
end
