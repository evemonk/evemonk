# frozen_string_literal: true

require "rails_helper"

describe "Api::Eve::ServerStatusLastsController" do
  xdescribe "#show" do
    it "returns last eve server status" do
      create(:eve_server_status,
        players: 28_384,
        server_version: "1550977",
        start_time: "2019-08-17T11:01:55Z",
        vip: false)

      get "/api/eve/server_status_last"

      expect(response).to have_http_status(:ok)

      expect(response.parsed_body).to eq("players" => 28_384,
        "server_version" => "1550977",
        "start_time" => "2019-08-17T11:01:55Z",
        "vip" => false)
    end
  end
end
