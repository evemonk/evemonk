# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::CategoriesController do
  describe "routing" do
    it "should route GET /universe/categories to universe/categories#index" do
      expect(get: "/universe/categories").to route_to(
        controller: "universe/categories",
        action: "index"
      )
    end

    it "should route GET /universe/categories/:id to universe/categories#show" do
      expect(get: "/universe/categories/1").to route_to(
        controller: "universe/categories",
        action: "show",
        id: "1"
      )
    end
  end
end
