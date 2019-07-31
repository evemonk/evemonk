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
             home_station_id: 999)

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

      expect(JSON.parse(response.body).keys.sort).to eq(["characters", "current_page", "total_count", "total_pages"])

      expect(JSON.parse(response.body)["total_count"]).to eq(1)

      expect(JSON.parse(response.body)["total_pages"]).to eq(1)

      expect(JSON.parse(response.body)["current_page"]).to eq(1)

      expect(JSON.parse(response.body)["characters"].size).to eq(1)

      expect(JSON.parse(response.body)["characters"].first.keys.sort).to eq(["alliance", "corporation", "icon", "id", "name"])

      expect(JSON.parse(response.body)["characters"].first["id"]).to eq(123_123_123)

      expect(JSON.parse(response.body)["characters"].first["icon"]).to eq("https://imageserver.eveonline.com/Character/123123123_512.jpg")

      expect(JSON.parse(response.body)["characters"].first["name"]).to eq("Character name")

      expect(JSON.parse(response.body)["characters"].first["alliance"].keys.sort).to eq(["creator_corporation_id",
                                                                                         "creator_id",
                                                                                         "date_founded",
                                                                                         "executor_corporation_id",
                                                                                         "faction_id",
                                                                                         "id",
                                                                                         "name",
                                                                                         "ticker",])

      expect(JSON.parse(response.body)["characters"].first["alliance"]["creator_corporation_id"]).to eq(2222)

      expect(JSON.parse(response.body)["characters"].first["alliance"]["creator_id"]).to eq(3333)

      expect(JSON.parse(response.body)["characters"].first["alliance"]["date_founded"]).to eq("2015-05-03T19:45:17Z")

      expect(JSON.parse(response.body)["characters"].first["alliance"]["executor_corporation_id"]).to eq(4444)

      expect(JSON.parse(response.body)["characters"].first["alliance"]["faction_id"]).to eq(5555)

      expect(JSON.parse(response.body)["characters"].first["alliance"]["id"]).to eq(123)

      expect(JSON.parse(response.body)["characters"].first["alliance"]["name"]).to eq("Alliance name")

      expect(JSON.parse(response.body)["characters"].first["alliance"]["ticker"]).to eq("ALLIANCE_TICKER")

      expect(JSON.parse(response.body)["characters"].first["corporation"].keys.sort).to eq(["alliance_id",
                                                                                            "ceo_id",
                                                                                            "creator_id",
                                                                                            "date_founded",
                                                                                            "description",
                                                                                            "faction_id",
                                                                                            "home_station_id",
                                                                                            "id",
                                                                                            "member_count",
                                                                                            "name",
                                                                                            "shares",
                                                                                            "tax_rate",
                                                                                            "ticker",
                                                                                            "url",])

      expect(JSON.parse(response.body)["characters"].first["corporation"]["alliance_id"]).to eq(123)

      expect(JSON.parse(response.body)["characters"].first["corporation"]["ceo_id"]).to eq(1234)

      expect(JSON.parse(response.body)["characters"].first["corporation"]["creator_id"]).to eq(4321)

      expect(JSON.parse(response.body)["characters"].first["corporation"]["date_founded"]).to eq("2015-05-03T19:45:17Z")

      expect(JSON.parse(response.body)["characters"].first["corporation"]["description"]).to eq("Character corporation description")

      expect(JSON.parse(response.body)["characters"].first["corporation"]["faction_id"]).to eq(5555)

      expect(JSON.parse(response.body)["characters"].first["corporation"]["home_station_id"]).to eq(999)

      expect(JSON.parse(response.body)["characters"].first["corporation"]["id"]).to eq(456)

      expect(JSON.parse(response.body)["characters"].first["corporation"]["member_count"]).to eq(2000)

      expect(JSON.parse(response.body)["characters"].first["corporation"]["name"]).to eq("Character corporation name")

      expect(JSON.parse(response.body)["characters"].first["corporation"]["shares"]).to eq(1000)

      expect(JSON.parse(response.body)["characters"].first["corporation"]["tax_rate"]).to eq("0.99")

      expect(JSON.parse(response.body)["characters"].first["corporation"]["ticker"]).to eq("TICKER")

      expect(JSON.parse(response.body)["characters"].first["corporation"]["url"]).to eq("https://evemonk.com/")
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
