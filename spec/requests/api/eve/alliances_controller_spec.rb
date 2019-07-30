# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::AlliancesController do
  describe "#index" do
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
             description: "<b>Creator corporation description<b>",
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
             description: "<b>Creator description</b>",
             gender: "male",
             birthday: "Sun, 03 May 2015 19:45:17 UTC +00:00",
             security_status: 1.1,
             title: "Creator title")

      create(:eve_corporation,
             alliance_id: 123,
             corporation_id: 123_123_123_123,
             description: "<b>Executor corporation description<b>",
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
                                                "icon" => "https://imageserver.eveonline.com/Alliance/123_128.png",
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
                                                  "icon" => "https://imageserver.eveonline.com/Corporation/123123_256.png",
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
                                                  "war_eligible" => false,
                                                },
                                                "creator" => {
                                                  "id" => 123_123_123,
                                                  "icon" => "https://imageserver.eveonline.com/Character/123123123_512.jpg",
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
                                                  "title" => "Creator title",
                                                },
                                                "executor_corporation" => {
                                                  "id" => 123_123_123_123,
                                                  "icon" => "https://imageserver.eveonline.com/Corporation/123123123123_256.png",
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
                                                  "war_eligible" => false,
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
                                                  "is_unique" => true,
                                                },
                                              }])
    end
  end

  describe "#show" do
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
             description: "<b>Creator corporation description<b>",
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
             description: "<b>Creator description</b>",
             gender: "male",
             birthday: "Sun, 03 May 2015 19:45:17 UTC +00:00",
             security_status: 1.1,
             title: "Creator title")

      create(:eve_corporation,
             alliance_id: 123,
             corporation_id: 123_123_123_123,
             description: "<b>Executor corporation description<b>",
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

      expect(JSON.parse(response.body)).to eq("alliance" => {
        "id" => 123,
        "icon" => "https://imageserver.eveonline.com/Alliance/123_128.png",
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
          "icon" => "https://imageserver.eveonline.com/Corporation/123123_256.png",
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
          "war_eligible" => false,
        },
        "creator" => {
          "id" => 123_123_123,
          "icon" => "https://imageserver.eveonline.com/Character/123123123_512.jpg",
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
          "title" => "Creator title",
        },
        "executor_corporation" => {
          "id" => 123_123_123_123,
          "icon" => "https://imageserver.eveonline.com/Corporation/123123123123_256.png",
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
          "war_eligible" => false,
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
          "is_unique" => true,
        },
      })
    end

    it "returns 404" do
      get "/api/eve/alliances/123"

      expect(response).to have_http_status(:not_found)
    end
  end
end
