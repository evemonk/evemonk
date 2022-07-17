# frozen_string_literal: true

require "rails_helper"

describe Blueprints::CopyingController do
  describe "routing" do
    it "should route GET /blueprints/copying/:id to blueprints/copying#show" do
      expect(get: "/blueprints/copying/24699").to route_to(
        controller: "blueprints/copying",
        action: "show",
        id: "24699"
      )
    end
  end
end
