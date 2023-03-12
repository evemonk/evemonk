# frozen_string_literal: true

require "rails_helper"

describe "Api::Eve::CharacterCorporationsHistoryController" do
  before { Setting.use_image_proxy = true }

  xdescribe "#index" do
    it "returns Eve Character corporation history" do
      create(:eve_character,
        character_id: 123,
        corporation_id: 456)

      create(:eve_corporation,
        alliance_id: 123,
        corporation_id: 456,
        name: "Character corporation name",
        description: "Character corporation description",
        ticker: "TICKER",
        date_founded: "Sun, 03 May 2015 19:45:17 UTC +00:00",
        corporation_url: "https://evemonk.com/",
        member_count: 2000,
        shares: 1000,
        tax_rate: 0.99,
        ceo_id: 1234,
        creator_id: 4321,
        faction_id: 5555,
        home_station_id: 999,
        war_eligible: false)

      create(:eve_character_corporation_history,
        character_id: 123,
        corporation_id: 456,
        is_deleted: false,
        record_id: 1,
        start_date: "Sun, 03 May 2015 19:45:17 UTC +00:00")

      get "/api/eve/characters/123/corporations_history"

      expect(response).to have_http_status(:ok)

      expect(response.parsed_body).to eq("current_page" => 1,
        "total_count" => 1,
        "total_pages" => 1,
        "history" => [{
          "character_id" => 123,
          "corporation_id" => 456,
          "is_deleted" => false,
          "record_id" => 1,
          "start_date" => "2015-05-03T19:45:17Z",
          "corporation" => {
            "id" => 456,
            "icon" => {
              "tiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/456/logo?size=32",
              "small" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/456/logo?size=64",
              "medium" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/456/logo?size=128",
              "large" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/456/logo?size=256"
            },
            "name" => "Character corporation name",
            "description" => "Character corporation description",
            "ticker" => "TICKER",
            "date_founded" => "2015-05-03T19:45:17Z",
            "url" => "https://evemonk.com/",
            "member_count" => 2000,
            "shares" => 1000,
            "tax_rate" => "0.99",
            "alliance_id" => 123,
            "ceo_id" => 1234,
            "creator_id" => 4321,
            "faction_id" => 5555,
            "home_station_id" => 999,
            "war_eligible" => false
          }
        }])
    end

    xit "returns 404" do
      get "/api/eve/characters/456/corporations_history"

      expect(response).to have_http_status(:not_found)
    end
  end
end
