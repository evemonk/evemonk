# frozen_string_literal: true

require "rails_helper"

RSpec.describe GraphqlController do
  describe "routing" do
    it "should route POST /graphql to graphql#execute" do
      expect(post: "/graphql").to route_to(
        controller: "graphql",
        action: "execute"
      )
    end
  end
end
