# frozen_string_literal: true

require "rails_helper"

describe TermsOfServicesController do
  describe "routing" do
    it "should route GET /terms_of_service to terms_of_services#show" do
      expect(get: "/terms_of_service").to route_to(
        controller: "terms_of_services",
        action: "show"
      )
    end
  end
end
