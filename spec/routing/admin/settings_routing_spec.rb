# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::SettingsController do
  describe "routing" do
    it "should route GET /admin/settings to admin/settings#index" do
      expect(get: "/admin/settings").to route_to(
        controller: "admin/settings",
        action: "index"
      )
    end

    it "should route POST /admin/settings to admin/settings#create" do
      expect(post: "/admin/settings").to route_to(
        controller: "admin/settings",
        action: "create"
      )
    end

    it "should route GET /admin/settings/new to admin/settings#new" do
      expect(get: "/admin/settings/new").to route_to(
        controller: "admin/settings",
        action: "new"
      )
    end

    it "should route GET /admin/settings/:id/edit to admin/settings#edit" do
      expect(get: "/admin/settings/1/edit").to route_to(
        controller: "admin/settings",
        action: "edit",
        id: "1"
      )
    end

    it "should route GET /admin/settings/:id to admin/settings#show" do
      expect(get: "/admin/settings/1").to route_to(
        controller: "admin/settings",
        action: "show",
        id: "1"
      )
    end

    it "should route PATCH /admin/settings/:id to admin/settings#update" do
      expect(patch: "/admin/settings/1").to route_to(
        controller: "admin/settings",
        action: "update",
        id: "1"
      )
    end

    it "should route PUT /admin/settings/:id to admin/settings#update" do
      expect(put: "/admin/settings/1").to route_to(
        controller: "admin/settings",
        action: "update",
        id: "1"
      )
    end

    it "should route DELETE /admin/settings/:id to admin/settings#destroy" do
      expect(delete: "/admin/settings/1").to route_to(
        controller: "admin/settings",
        action: "destroy",
        id: "1"
      )
    end
  end
end
