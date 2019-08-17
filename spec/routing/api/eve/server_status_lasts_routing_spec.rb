# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::ServerStatusLastsController do
  describe "routing" do
    it "should route GET /api/eve/server_status_last to api/eve/server_status_lasts#show" do
      expect(get: "/api/eve/server_status_last").to route_to(
        controller: "api/eve/server_status_lasts",
        action: "show",
        format: "json"
      )
    end
  end
end
