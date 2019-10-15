# frozen_string_literal: true

require "rails_helper"

describe EmploymentHistoryController do
  describe "routing" do
    it "should route GET /characters/90729314/employment_history to employment_history#index" do
      expect(get: "/characters/90729314/employment_history").to route_to(
        controller: "employment_history",
        action: "index",
        character_id: "90729314"
      )
    end
  end
end
