# frozen_string_literal: true

require "rails_helper"

RSpec.describe WellKnownController do
  describe "routing" do
    it "should route .well-known/change-password to well_known#change_password" do
      expect(get: "/.well-known/change-password").to route_to("well_known#change_password")
    end
  end
end
