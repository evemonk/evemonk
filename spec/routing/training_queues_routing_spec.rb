# frozen_string_literal: true

require "rails_helper"

RSpec.describe TrainingQueuesController do
  describe "routing" do
    it "should route GET /characters/:character_id/training_queues to training_queues#index" do
      expect(get: "/characters/90729314/training_queues").to route_to(
        controller: "training_queues",
        action: "index",
        character_id: "90729314"
      )
    end
  end
end
