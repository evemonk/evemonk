# frozen_string_literal: true

require "rails_helper"

RSpec.describe CertificatesController do
  describe "routing" do
    it "should route GET /characters/:character_id/certificates to certificates#index" do
      expect(get: "/characters/90729314/certificates").to route_to(
        controller: "certificates",
        action: "index",
        character_id: "90729314"
      )
    end
  end
end
