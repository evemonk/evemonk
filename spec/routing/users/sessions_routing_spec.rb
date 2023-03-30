# frozen_string_literal: true

require "rails_helper"

describe Users::SessionsController do
  describe "routing" do
    it "should route GET /users/sign_in to users/sessions#new" do
      expect(get: "/users/sign_in").to route_to(
        controller: "users/sessions",
        action: "new"
      )
    end

    it "should route POST /users/sign_in to users/sessions#create" do
      expect(post: "/users/sign_in").to route_to(
        controller: "users/sessions",
        action: "create"
      )
    end

    it "should route DELETE /users/sign_out to users/sessions#destroy" do
      expect(delete: "/users/sign_out").to route_to(
        controller: "users/sessions",
        action: "destroy"
      )
    end

    it "should route POST /users/pre_otp to users/sessions#pre_otp" do
      expect(post: "/users/pre_otp").to route_to(
        controller: "users/sessions",
        action: "pre_otp"
      )
    end
  end
end
