# frozen_string_literal: true

require "rails_helper"

describe SignInsController do
  describe "routing" do
    it "should route GET /sign_in to sign_ins#show" do
      expect(get: "/sign_in").to route_to(
        controller: "sign_ins",
        action: "show"
      )
    end

    it "should route POST /sign_in to sign_ins#create" do
      expect(post: "/sign_in").to route_to(
        controller: "sign_ins",
        action: "create"
      )
    end
  end
end
