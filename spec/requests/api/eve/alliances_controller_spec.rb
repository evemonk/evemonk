# frozen_string_literal: true

require "rails_helper"

describe "Api::Eve::AlliancesController" do
  before { Setting.use_image_proxy = true }

  xdescribe "#index" do
    it "returns list of Eve Alliances" do
      create(:eve_faction,
        faction_id: 777,
        name: "Faction name",
        description: "Faction description",
        solar_system_id: 10,
        corporation_id: 456,
        militia_corporation_id: 20,
        size_factor: 2.0,
        station_count: 10,
        station_system_count: 100,
        is_unique: true)

      create(:eve_alliance,
        alliance_id: 123,
        creator_corporation_id: 123_123,
        creator_id: 123_123_123,
        date_founded: "Sun, 03 May 2015 19:45:17 UTC +00:00",
        executor_corporation_id: 123_123_123_123,
        faction_id: 777,
        name: "Alliance name",
        ticker: "ALLIANCE_TICKER")

      create(:eve_corporation,
        alliance_id: 123,
        corporation_id: 456,
        member_count: 1234)

      create(:eve_alliance_corporation,
        alliance_id: 123,
        corporation_id: 456)

      create(:eve_corporation,
        alliance_id: 123,
        corporation_id: 123_123,
        description: "Creator corporation description",
        name: "Creator corporation name",
        ticker: "CREATORTICKER",
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

      create(:eve_character,
        alliance_id: 123,
        character_id: 123_123_123,
        corporation_id: 456,
        ancestry_id: 10,
        bloodline_id: 12,
        faction_id: 5555,
        race_id: 123,
        name: "Creator name",
        description: "Creator description",
        gender: "male",
        birthday: "Sun, 03 May 2015 19:45:17 UTC +00:00",
        security_status: 1.1,
        title: "Creator title")

      create(:eve_corporation,
        alliance_id: 123,
        corporation_id: 123_123_123_123,
        description: "Executor corporation description",
        name: "Executor corporation name",
        ticker: "EXECUTORTICKER",
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

      get "/api/eve/alliances"

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq("total_count" => 1,
                                              "total_pages" => 1,
                                              "current_page" => 1,
                                              "alliances" => [{
                                                "id" => 123,
                                                "icon" => {
                                                  "tiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/alliances/123/logo?size=32",
                                                  "small" => "https://imageproxy.evemonk.com/https://images.evetech.net/alliances/123/logo?size=64",
                                                  "medium" => "https://imageproxy.evemonk.com/https://images.evetech.net/alliances/123/logo?size=128"
                                                },
                                                "creator_corporation_id" => 123_123,
                                                "creator_id" => 123_123_123,
                                                "date_founded" => "2015-05-03T19:45:17Z",
                                                "executor_corporation_id" => 123_123_123_123,
                                                "faction_id" => 777,
                                                "name" => "Alliance name",
                                                "ticker" => "ALLIANCE_TICKER",
                                                "corporations_count" => 1,
                                                "characters_count" => 1234,
                                                "creator_corporation" => {
                                                  "id" => 123_123,
                                                  "icon" => {
                                                    "tiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123123/logo?size=32",
                                                    "small" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123123/logo?size=64",
                                                    "medium" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123123/logo?size=128",
                                                    "large" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123123/logo?size=256"
                                                  },
                                                  "name" => "Creator corporation name",
                                                  "description" => "Creator corporation description",
                                                  "ticker" => "CREATORTICKER",
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
                                                },
                                                "creator" => {
                                                  "id" => 123_123_123,
                                                  "icon" => {
                                                    "tiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123123123/portrait?size=32",
                                                    "small" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123123123/portrait?size=64",
                                                    "medium" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123123123/portrait?size=128",
                                                    "large" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123123123/portrait?size=256",
                                                    "huge" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123123123/portrait?size=512",
                                                    "gigantic" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123123123/portrait?size=1024"
                                                  },
                                                  "alliance_id" => 123,
                                                  "ancestry_id" => 10,
                                                  "birthday" => "2015-05-03T19:45:17Z",
                                                  "bloodline_id" => 12,
                                                  "corporation_id" => 456,
                                                  "description" => "Creator description",
                                                  "faction_id" => 5555,
                                                  "gender" => "male",
                                                  "name" => "Creator name",
                                                  "race_id" => 123,
                                                  "security_status" => "1.1",
                                                  "title" => "Creator title"
                                                },
                                                "executor_corporation" => {
                                                  "id" => 123_123_123_123,
                                                  "icon" => {
                                                    "tiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123123123123/logo?size=32",
                                                    "small" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123123123123/logo?size=64",
                                                    "medium" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123123123123/logo?size=128",
                                                    "large" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123123123123/logo?size=256"
                                                  },
                                                  "name" => "Executor corporation name",
                                                  "description" => "Executor corporation description",
                                                  "ticker" => "EXECUTORTICKER",
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
                                                },
                                                "faction" => {
                                                  "id" => 777,
                                                  "corporation_id" => 456,
                                                  "name" => "Faction name",
                                                  "description" => "Faction description",
                                                  "militia_corporation_id" => 20,
                                                  "solar_system_id" => 10,
                                                  "station_count" => 10,
                                                  "station_system_count" => 100,
                                                  "size_factor" => "2.0",
                                                  "is_unique" => true
                                                }
                                              }])
    end
  end

  xdescribe "#show" do
    it "returns Eve Alliance" do
      create(:eve_faction,
        faction_id: 777,
        name: "Faction name",
        description: "Faction description",
        solar_system_id: 10,
        corporation_id: 456,
        militia_corporation_id: 20,
        size_factor: 2.0,
        station_count: 10,
        station_system_count: 100,
        is_unique: true)

      create(:eve_alliance,
        alliance_id: 123,
        creator_corporation_id: 123_123,
        creator_id: 123_123_123,
        date_founded: "Sun, 03 May 2015 19:45:17 UTC +00:00",
        executor_corporation_id: 123_123_123_123,
        faction_id: 777,
        name: "Alliance name",
        ticker: "ALLIANCE_TICKER")

      create(:eve_corporation,
        alliance_id: 123,
        corporation_id: 456,
        member_count: 1234)

      create(:eve_alliance_corporation,
        alliance_id: 123,
        corporation_id: 456)

      create(:eve_corporation,
        alliance_id: 123,
        corporation_id: 123_123,
        description: "Creator corporation description",
        name: "Creator corporation name",
        ticker: "CREATORTICKER",
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

      create(:eve_character,
        alliance_id: 123,
        character_id: 123_123_123,
        corporation_id: 456,
        ancestry_id: 10,
        bloodline_id: 12,
        faction_id: 5555,
        race_id: 123,
        name: "Creator name",
        description: "Creator description",
        gender: "male",
        birthday: "Sun, 03 May 2015 19:45:17 UTC +00:00",
        security_status: 1.1,
        title: "Creator title")

      create(:eve_corporation,
        alliance_id: 123,
        corporation_id: 123_123_123_123,
        description: "Executor corporation description",
        name: "Executor corporation name",
        ticker: "EXECUTORTICKER",
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

      get "/api/eve/alliances/123"

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq("id" => 123,
                                              "icon" => {
                                                "tiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/alliances/123/logo?size=32",
                                                "small" => "https://imageproxy.evemonk.com/https://images.evetech.net/alliances/123/logo?size=64",
                                                "medium" => "https://imageproxy.evemonk.com/https://images.evetech.net/alliances/123/logo?size=128"
                                              },
                                              "creator_corporation_id" => 123_123,
                                              "creator_id" => 123_123_123,
                                              "date_founded" => "2015-05-03T19:45:17Z",
                                              "executor_corporation_id" => 123_123_123_123,
                                              "faction_id" => 777,
                                              "name" => "Alliance name",
                                              "ticker" => "ALLIANCE_TICKER",
                                              "corporations_count" => 1,
                                              "characters_count" => 1234,
                                              "creator_corporation" => {
                                                "id" => 123_123,
                                                "icon" => {
                                                  "tiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123123/logo?size=32",
                                                  "small" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123123/logo?size=64",
                                                  "medium" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123123/logo?size=128",
                                                  "large" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123123/logo?size=256"
                                                },
                                                "name" => "Creator corporation name",
                                                "description" => "Creator corporation description",
                                                "ticker" => "CREATORTICKER",
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
                                              },
                                              "creator" => {
                                                "id" => 123_123_123,
                                                "icon" => {
                                                  "tiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123123123/portrait?size=32",
                                                  "small" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123123123/portrait?size=64",
                                                  "medium" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123123123/portrait?size=128",
                                                  "large" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123123123/portrait?size=256",
                                                  "huge" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123123123/portrait?size=512",
                                                  "gigantic" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123123123/portrait?size=1024"
                                                },
                                                "alliance_id" => 123,
                                                "ancestry_id" => 10,
                                                "birthday" => "2015-05-03T19:45:17Z",
                                                "bloodline_id" => 12,
                                                "corporation_id" => 456,
                                                "description" => "Creator description",
                                                "faction_id" => 5555,
                                                "gender" => "male",
                                                "name" => "Creator name",
                                                "race_id" => 123,
                                                "security_status" => "1.1",
                                                "title" => "Creator title"
                                              },
                                              "executor_corporation" => {
                                                "id" => 123_123_123_123,
                                                "icon" => {
                                                  "tiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123123123123/logo?size=32",
                                                  "small" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123123123123/logo?size=64",
                                                  "medium" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123123123123/logo?size=128",
                                                  "large" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123123123123/logo?size=256"
                                                },
                                                "name" => "Executor corporation name",
                                                "description" => "Executor corporation description",
                                                "ticker" => "EXECUTORTICKER",
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
                                              },
                                              "faction" => {
                                                "id" => 777,
                                                "corporation_id" => 456,
                                                "name" => "Faction name",
                                                "description" => "Faction description",
                                                "militia_corporation_id" => 20,
                                                "solar_system_id" => 10,
                                                "station_count" => 10,
                                                "station_system_count" => 100,
                                                "size_factor" => "2.0",
                                                "is_unique" => true
                                              })
    end

    it "returns 404" do
      get "/api/eve/alliances/123"

      expect(response).to have_http_status(:not_found)
    end
  end
end
