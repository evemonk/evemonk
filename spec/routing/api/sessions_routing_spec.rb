# frozen_string_literal: true

require "rails_helper"

describe Api::SessionsController do
  describe "routing" do
    it "should route DELETE /api/sessions/:id to api/sessions#destroy" do
      expect(delete: "/api/sessions/1234").to route_to(
        controller: "api/sessions",
        action: "destroy",
        format: "json",
        id: "1234"
      )
    end
  end
end
