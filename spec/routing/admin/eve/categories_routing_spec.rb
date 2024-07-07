# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::Eve::CategoriesController do
  describe "routing" do
    it "should route GET /admin/eve/categories to admin/eve/categories#index" do
      expect(get: "/admin/eve/categories").to route_to(
        controller: "admin/eve/categories",
        action: "index"
      )
    end

    it "should route GET /admin/eve/categories/:id to admin/eve/categories#show" do
      expect(get: "/admin/eve/categories/1").to route_to(
        controller: "admin/eve/categories",
        action: "show",
        id: "1"
      )
    end
  end
end
