# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::UsersController do
  describe "routing" do
    it "should route GET /admin/users to admin/users#index" do
      expect(get: "/admin/users").to route_to(
        controller: "admin/users",
        action: "index"
      )
    end

    it "should route POST /admin/users to admin/users#create" do
      expect(post: "/admin/users").to route_to(
        controller: "admin/users",
        action: "create"
      )
    end

    it "should route GET /admin/users/new to admin/users#new" do
      expect(get: "/admin/users/new").to route_to(
        controller: "admin/users",
        action: "new"
      )
    end

    it "should route GET /admin/users/:id/edit to admin/users#edit" do
      expect(get: "/admin/users/1/edit").to route_to(
        controller: "admin/users",
        action: "edit",
        id: "1"
      )
    end

    it "should route GET /admin/users/:id to admin/users#show" do
      expect(get: "/admin/users/1").to route_to(
        controller: "admin/users",
        action: "show",
        id: "1"
      )
    end

    it "should route PATCH /admin/users/:id to admin/users#update" do
      expect(patch: "/admin/users/1").to route_to(
        controller: "admin/users",
        action: "update",
        id: "1"
      )
    end

    it "should route PUT /admin/users/:id to admin/users#update" do
      expect(put: "/admin/users/1").to route_to(
        controller: "admin/users",
        action: "update",
        id: "1"
      )
    end

    it "should route DELETE /admin/users/:id to admin/users#destroy" do
      expect(delete: "/admin/users/1").to route_to(
        controller: "admin/users",
        action: "destroy",
        id: "1"
      )
    end
  end
end
