# frozen_string_literal: true

require "rails_helper"

describe SignOutsController do
  describe "routing" do
    it "should route DELETE /sign_out to sign_outs#destroy" do
      expect(delete: "/sign_out").to route_to(
        controller: "sign_outs",
        action: "destroy"
      )
    end
  end
end
