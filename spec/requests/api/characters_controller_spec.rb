# frozen_string_literal: true

require "rails_helper"

describe Api::CharactersController do
  describe "#index" do
    it "returns list of user characters" do
      user = create(:user)

      session = create(:session, user: user)

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
             war_eligible: true)

      create(:eve_alliance_corporation,
             alliance_id: 123,
             corporation_id: 456)

      create(:character,
             user: user,
             alliance_id: 123,
             character_id: 123_123_123,
             corporation_id: 456,
             name: "Character name")

      get "/api/characters", headers: {'Authorization': "Bearer #{session.token}"}

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq("total_count" => 1,
                                              "total_pages" => 1,
                                              "current_page" => 1,
                                              "characters" => [{
                                                "id" => 123_123_123,
                                                "icon" => {
                                                  "tiny" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123123123_32.png",
                                                  "small" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123123123_64.png",
                                                  "medium" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123123123_128.png",
                                                  "large" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123123123_256.png",
                                                  "huge" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123123123_512.png",
                                                  "gigantic" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123123123_1024.png",
                                                },
                                                "name" => "Character name",
                                                "alliance" => {
                                                  "id" => 123,
                                                  "icon" => {
                                                    "tiny" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Alliance/123_32.png",
                                                    "small" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Alliance/123_64.png",
                                                    "medium" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Alliance/123_128.png",
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
                                                "corporation" => {
                                                  "id" => 456,
                                                  "icon" => {
                                                    "tiny" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Corporation/456_32.png",
                                                    "small" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Corporation/456_64.png",
                                                    "medium" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Corporation/456_128.png",
                                                    "large" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Corporation/456_256.png",
                                                  },
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
                                                  "war_eligible" => true,
                                                },
                                              }])
    end
  end

  describe "#show" do
    it "returns user character info" do
      user = create(:user)

      session = create(:session, user: user)

      alliance = create(:eve_alliance,
                        alliance_id: 1234,
                        name: "Alliance name")

      corporation = create(:eve_corporation,
                           alliance_id: alliance.alliance_id,
                           corporation_id: 12_345,
                           name: "Corporation name")

      race = create(:eve_race,
                    race_id: 124,
                    name: "Race name")

      bloodline = create(:eve_bloodline,
                         bloodline_id: 125,
                         name: "Bloodline name")

      ancestry = create(:eve_ancestry,
                        ancestry_id: 126,
                        name: "Ancestry name")

      faction = create(:eve_faction,
                       faction_id: 127,
                       name: "Faction name")

      character = create(:character,
                         user: user,
                         alliance_id: alliance.alliance_id,
                         corporation_id: corporation.corporation_id,
                         race_id: race.race_id,
                         bloodline_id: bloodline.bloodline_id,
                         ancestry_id: ancestry.ancestry_id,
                         faction_id: faction.faction_id,
                         character_id: "123",
                         name: "Character name",
                         description: "Character description",
                         birthday: "2010-01-15T15:26:00Z",
                         gender: "male",
                         charisma: 20,
                         intelligence: 21,
                         memory: 22,
                         perception: 23,
                         willpower: 24,
                         security_status: 1.8,
                         wallet: 252.49,
                         bonus_remaps: 2,
                         last_remap_date: "2011-05-07T12:58:06Z",
                         accrued_remap_cooldown_date: "2012-05-06T12:58:06Z")

      get "/api/characters/#{character.character_id}", headers: {'Authorization': "Bearer #{session.token}"}

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body).keys.sort).to eq(["character"])

      expect(JSON.parse(response.body)["character"].keys.sort).to eq(["accrued_remap_cooldown_date",
                                                                      "alliance",
                                                                      "ancestry",
                                                                      "birthday",
                                                                      "bloodline",
                                                                      "bonus_remaps",
                                                                      "charisma",
                                                                      "corporation",
                                                                      "description",
                                                                      "faction",
                                                                      "gender",
                                                                      "icon",
                                                                      "id",
                                                                      "intelligence",
                                                                      "last_remap_date",
                                                                      "memory",
                                                                      "name",
                                                                      "perception",
                                                                      "race",
                                                                      "security_status",
                                                                      "wallet",
                                                                      "willpower",])

      expect(JSON.parse(response.body)["character"]["id"]).to eq(123)

      expect(JSON.parse(response.body)["character"]["icon"]).to eq("https://imageserver.eveonline.com/Character/123_512.jpg")

      expect(JSON.parse(response.body)["character"]["name"]).to eq("Character name")

      expect(JSON.parse(response.body)["character"]["description"]).to eq("Character description")

      expect(JSON.parse(response.body)["character"]["birthday"]).to eq("2010-01-15T15:26:00Z")

      expect(JSON.parse(response.body)["character"]["gender"]).to eq("male")

      expect(JSON.parse(response.body)["character"]["charisma"]).to eq(20)

      expect(JSON.parse(response.body)["character"]["intelligence"]).to eq(21)

      expect(JSON.parse(response.body)["character"]["memory"]).to eq(22)

      expect(JSON.parse(response.body)["character"]["perception"]).to eq(23)

      expect(JSON.parse(response.body)["character"]["willpower"]).to eq(24)

      expect(JSON.parse(response.body)["character"]["security_status"]).to eq("1.8")

      expect(JSON.parse(response.body)["character"]["wallet"]).to eq("252.49 ISK")

      expect(JSON.parse(response.body)["character"]["bonus_remaps"]).to eq(2)

      expect(JSON.parse(response.body)["character"]["last_remap_date"]).to eq("2011-05-07T12:58:06Z")

      expect(JSON.parse(response.body)["character"]["accrued_remap_cooldown_date"]).to eq("2012-05-06T12:58:06Z")

      expect(JSON.parse(response.body)["character"]["race"].keys.sort).to eq(["id", "name"])

      expect(JSON.parse(response.body)["character"]["race"]["id"]).to eq(124)

      expect(JSON.parse(response.body)["character"]["race"]["name"]).to eq("Race name")

      expect(JSON.parse(response.body)["character"]["bloodline"].keys.sort).to eq(["id", "name"])

      expect(JSON.parse(response.body)["character"]["bloodline"]["id"]).to eq(125)

      expect(JSON.parse(response.body)["character"]["bloodline"]["name"]).to eq("Bloodline name")

      expect(JSON.parse(response.body)["character"]["ancestry"].keys.sort).to eq(["id", "name"])

      expect(JSON.parse(response.body)["character"]["ancestry"]["id"]).to eq(126)

      expect(JSON.parse(response.body)["character"]["ancestry"]["name"]).to eq("Ancestry name")

      expect(JSON.parse(response.body)["character"]["faction"].keys.sort).to eq(["id", "name"])

      expect(JSON.parse(response.body)["character"]["faction"]["id"]).to eq(127)

      expect(JSON.parse(response.body)["character"]["faction"]["name"]).to eq("Faction name")

      expect(JSON.parse(response.body)["character"]["alliance"].keys.sort).to eq(["id", "name"])

      expect(JSON.parse(response.body)["character"]["alliance"]["id"]).to eq(1234)

      expect(JSON.parse(response.body)["character"]["alliance"]["name"]).to eq("Alliance name")

      expect(JSON.parse(response.body)["character"]["corporation"].keys.sort).to eq(["id", "name"])

      expect(JSON.parse(response.body)["character"]["corporation"]["id"]).to eq(12_345)

      expect(JSON.parse(response.body)["character"]["corporation"]["name"]).to eq("Corporation name")
    end
  end
end
