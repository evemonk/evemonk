# frozen_string_literal: true

require "rails_helper"

RSpec.describe Universe::TypesController do
  describe "routing" do
    it "should route GET /universe/types/:id to universe/types#show" do
      expect(get: "/universe/types/4259").to route_to(
        controller: "universe/types",
        action: "show",
        id: "4259"
      )
    end
  end
end
