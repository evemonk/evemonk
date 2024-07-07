# frozen_string_literal: true

require "rails_helper"

RSpec.describe IndustryJobsController do
  describe "routing" do
    it "should route GET /characters/:character_id/industry_jobs to industry_jobs#index" do
      expect(get: "/characters/90729314/industry_jobs").to route_to(
        controller: "industry_jobs",
        action: "index",
        character_id: "90729314"
      )
    end
  end
end
