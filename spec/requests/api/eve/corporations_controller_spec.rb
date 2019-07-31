# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::CorporationsController do
  describe "#index" do
    it "returns list of Eve Corporations" do
      create(:eve_alliance,
             alliance_id: 123)

      create(:eve_corporation,
             alliance_id: 123,
             corporation_id: 456,
             name: "Character corporation name",
             description: "<b>Character corporation description</b>",
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

      get "/api/eve/corporations"

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq("current_page" => 1,
                                              "total_count" => 1,
                                              "total_pages" => 1,
                                              "corporations" => [{
                                                "id" => 456,
                                                "icon" => "https://imageserver.eveonline.com/Corporation/456_256.png",
                                                "alliance_id" => 123,
                                                "ceo_id" => 1234,
                                                "creator_id" => 4321,
                                                "date_founded" => "2015-05-03T19:45:17Z",
                                                "description" => "Character corporation description",
                                                "faction_id" => 5555,
                                                "home_station_id" => 999,
                                                "member_count" => 2000,
                                                "name" => "Character corporation name",
                                                "shares" => 1000,
                                                "tax_rate" => "0.99",
                                                "ticker" => "TICKER",
                                                "corporation_url" => "https://evemonk.com/",
                                                "war_eligible" => false,
                                              }])
    end
  end

  describe "#show" do
    it "returns Eve Corporation" do
      create(:eve_alliance,
             alliance_id: 123,
             creator_corporation_id: 2222,
             creator_id: 3333,
             date_founded: "Sun, 03 May 2015 19:45:17 UTC +00:00",
             executor_corporation_id: 4444,
             faction_id: 5555,
             name: "Alliance name",
             ticker: "ALLIANCE_TICKER")

      create(:eve_corporation,
             alliance_id: 123,
             corporation_id: 456,
             name: "Character corporation name",
             description: "<b>Character corporation description</b>",
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

      create(:eve_alliance_corporation,
             alliance_id: 123,
             corporation_id: 456)

      create(:eve_character,
             alliance_id: 123,
             character_id: 1234,
             corporation_id: 456,
             ancestry_id: 10,
             bloodline_id: 12,
             faction_id: 5555,
             race_id: 123,
             name: "CEO name",
             description: "<b>CEO description</b>",
             gender: "male",
             birthday: "Sun, 03 May 2015 19:45:17 UTC +00:00",
             security_status: 1.1,
             title: "CEO title")

      create(:eve_character,
             alliance_id: 123,
             character_id: 4321,
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

      create(:eve_faction,
             faction_id: 5555,
             name: "Faction name",
             description: "Faction description",
             solar_system_id: 10,
             corporation_id: 456,
             militia_corporation_id: 20,
             size_factor: 2.0,
             station_count: 10,
             station_system_count: 100,
             is_unique: true)

      get "/api/eve/corporations/456"

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq("corporation" => {
        "id" => 456,
        "icon" => "https://imageserver.eveonline.com/Corporation/456_256.png",
        "alliance_id" => 123,
        "ceo_id" => 1234,
        "creator_id" => 4321,
        "date_founded" => "2015-05-03T19:45:17Z",
        "description" => "Character corporation description",
        "faction_id" => 5555,
        "home_station_id" => 999,
        "member_count" => 2000,
        "name" => "Character corporation name",
        "shares" => 1000,
        "tax_rate" => "0.99",
        "ticker" => "TICKER",
        "corporation_url" => "https://evemonk.com/",
        "war_eligible" => false,
        "alliance" => {
          "id" => 123,
          "icon" => "https://imageserver.eveonline.com/Alliance/123_128.png",
          "creator_corporation_id" => 2222,
          "creator_id" => 3333,
          "date_founded" => "2015-05-03T19:45:17Z",
          "executor_corporation_id" => 4444,
          "faction_id" => 5555,
          "name" => "Alliance name",
          "ticker" => "ALLIANCE_TICKER",
          "corporations_count" => 1,
          "characters_count" => 2000,
        },
        "ceo" => {
          "id" => 1234,
          "icon" => "https://imageserver.eveonline.com/Character/1234_512.jpg",
          "alliance_id" => 123,
          "ancestry_id" => 10,
          "birthday" => "2015-05-03T19:45:17Z",
          "bloodline_id" => 12,
          "corporation_id" => 456,
          "description" => "CEO description",
          "faction_id" => 5555,
          "gender" => "male",
          "name" => "CEO name",
          "race_id" => 123,
          "security_status" => "1.1",
          "title" => "CEO title",
        },
        "creator" => {
          "id" => 4321,
          "icon" => "https://imageserver.eveonline.com/Character/4321_512.jpg",
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
        "faction" => {
          "id" => 5555,
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
      get "/api/eve/corporations/123"

      expect(response).to have_http_status(:not_found)
    end
  end
end
