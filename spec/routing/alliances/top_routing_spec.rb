# frozen_string_literal: true

require "rails_helper"

describe Alliances::TopController do
  describe "routing" do
    it "should route GET /alliances/top to alliances/top#index" do
      expect(get: "/alliances/top").to route_to(
        controller: "alliances/top",
        action: "index"
      )
    end
  end
end
