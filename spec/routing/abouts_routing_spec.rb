# frozen_string_literal: true

require "rails_helper"

RSpec.describe AboutsController do
  describe "routing" do
    it "should route GET /about to abouts#show" do
      expect(get: "/about").to route_to(
        controller: "abouts",
        action: "show"
      )
    end
  end
end
