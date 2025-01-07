# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::SearchController, type: :routing do
  describe "routing" do
    it "should route GET /universe/search to universe/searches#index" do
      expect(get: "/universe/search").to route_to(
        controller: "universe/search",
        action: "index"
      )
    end
  end
end
