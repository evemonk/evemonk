# frozen_string_literal: true

require "rails_helper"

RSpec.describe EmploymentHistoriesController do
  describe "routing" do
    it "should route GET /characters/:character_id/employment_histories to employment_histories#index" do
      expect(get: "/characters/90729314/employment_histories").to route_to(
        controller: "employment_histories",
        action: "index",
        character_id: "90729314"
      )
    end
  end
end
