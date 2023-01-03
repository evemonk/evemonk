# frozen_string_literal: true

require "rails_helper"

describe Admin::Eve::CertificatesController do
  describe "routing" do
    it "should route GET /admin/eve/certificates to admin/eve/certificates#index" do
      expect(get: "/admin/eve/certificates").to route_to(
        controller: "admin/eve/certificates",
        action: "index"
      )
    end

    it "should route GET /admin/eve/certificates/:id to admin/eve/certificates#show" do
      expect(get: "/admin/eve/certificates/1").to route_to(
        controller: "admin/eve/certificates",
        action: "show",
        id: "1"
      )
    end
  end
end
