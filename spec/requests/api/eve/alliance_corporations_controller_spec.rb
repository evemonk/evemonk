# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::AllianceCorporationsController do
  describe "#index" do
    it "returns list of Eve Alliance Corporations" do
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
             description: "CEO description",
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
             description: "Creator description",
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

      get "/api/eve/alliances/123/corporations"

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq("total_count" => 1,
                                              "total_pages" => 1,
                                              "current_page" => 1,
                                              "corporations" => [{
                                                "id" => 456,
                                                "icon" => {
                                                  "large" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Corporation/456_256.png",
                                                  "medium" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Corporation/456_128.png",
                                                  "small" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Corporation/456_64.png",
                                                  "tiny" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Corporation/456_32.png",
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
                                                "war_eligible" => false,
                                                "alliance" => {
                                                  "id" => 123,
                                                  "icon" => {
                                                    "medium" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Alliance/123_128.png",
                                                    "small" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Alliance/123_64.png",
                                                    "tiny" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Alliance/123_32.png",
                                                  },
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
                                                  "icon" => {
                                                    "gigantic" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/1234_1024.png",
                                                    "huge" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/1234_512.png",
                                                    "large" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/1234_256.png",
                                                    "medium" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/1234_128.png",
                                                    "small" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/1234_64.png",
                                                    "tiny" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/1234_32.png",
                                                  },
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
                                                  "icon" => {
                                                    "gigantic" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/4321_1024.png",
                                                    "huge" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/4321_512.png",
                                                    "large" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/4321_256.png",
                                                    "medium" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/4321_128.png",
                                                    "small" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/4321_64.png",
                                                    "tiny" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/4321_32.png",
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
                                              }])
    end

    it "returns 404" do
      get "/api/eve/alliances/123/corporations"

      expect(response).to have_http_status(:not_found)
    end
  end
end
