# frozen_string_literal: true

require "rails_helper"

describe Corporations::TopController do
  describe "routing" do
    it "should route GET /corporations/top to corporations/top#index" do
      expect(get: "/corporations/top").to route_to(
        controller: "corporations/top",
        action: "index"
      )
    end
  end
end
