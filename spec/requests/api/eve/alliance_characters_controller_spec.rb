# frozen_string_literal: true

require "rails_helper"

describe Api::Eve::AllianceCharactersController do
  before { Setting.use_image_proxy = true }

  describe "#index" do
    it "returns list of Eve Alliance Characters" do
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
        character_id: 123_123_123,
        corporation_id: 456,
        ancestry_id: 10,
        bloodline_id: 12,
        faction_id: 5555,
        race_id: 123,
        name: "Character name",
        description: "Character description",
        gender: "male",
        birthday: "Sun, 03 May 2015 19:45:17 UTC +00:00",
        security_status: 1.1,
        title: "Character title")

      create(:eve_bloodline,
        bloodline_id: 12,
        name: "Bloodline name",
        description: "Bloodline description",
        race_id: 123,
        corporation_id: 456,
        ship_type_id: 30,
        perception: 21,
        willpower: 22,
        charisma: 23,
        memory: 24,
        intelligence: 25)

      create(:eve_ancestry,
        ancestry_id: 10,
        name: "Ancestry name",
        bloodline_id: 12,
        description: "Ancestry description",
        short_description: "Ancestry short description",
        icon_id: 14)

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

      create(:eve_race,
        race_id: 123,
        name: "Race name",
        description: "Race description",
        alliance_id: 123)

      get "/api/eve/alliances/123/characters"

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq("total_count" => 1,
                                              "total_pages" => 1,
                                              "current_page" => 1,
                                              "characters" => [{
                                                "id" => 123_123_123,
                                                "icon" => {
                                                  "tiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123123123/portrait?size=32",
                                                  "small" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123123123/portrait?size=64",
                                                  "medium" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123123123/portrait?size=128",
                                                  "large" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123123123/portrait?size=256",
                                                  "huge" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123123123/portrait?size=512",
                                                  "gigantic" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123123123/portrait?size=1024",
                                                },
                                                "alliance_id" => 123,
                                                "ancestry_id" => 10,
                                                "birthday" => "2015-05-03T19:45:17Z",
                                                "bloodline_id" => 12,
                                                "corporation_id" => 456,
                                                "description" => "Character description",
                                                "faction_id" => 5555,
                                                "gender" => "male",
                                                "name" => "Character name",
                                                "race_id" => 123,
                                                "security_status" => "1.1",
                                                "title" => "Character title",
                                                "alliance" => {
                                                  "id" => 123,
                                                  "icon" => {
                                                    "tiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/alliances/123/logo?size=32",
                                                    "small" => "https://imageproxy.evemonk.com/https://images.evetech.net/alliances/123/logo?size=64",
                                                    "medium" => "https://imageproxy.evemonk.com/https://images.evetech.net/alliances/123/logo?size=128",
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
                                                "ancestry" => {
                                                  "id" => 10,
                                                  "bloodline_id" => 12,
                                                  "name" => "Ancestry name",
                                                  "short_description" => "Ancestry short description",
                                                  "description" => "Ancestry description",
                                                  "icon_id" => 14,
                                                },
                                                "bloodline" => {
                                                  "id" => 12,
                                                  "corporation_id" => 456,
                                                  "race_id" => 123,
                                                  "name" => "Bloodline name",
                                                  "description" => "Bloodline description",
                                                  "charisma" => 23,
                                                  "intelligence" => 25,
                                                  "memory" => 24,
                                                  "perception" => 21,
                                                  "willpower" => 22,
                                                  "ship_type_id" => 30,
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
                                                "race" => {
                                                  "id" => 123,
                                                  "alliance_id" => 123,
                                                  "name" => "Race name",
                                                  "description" => "Race description",
                                                },
                                                "corporation" => {
                                                  "id" => 456,
                                                  "icon" => {
                                                    "tiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/456/logo?size=32",
                                                    "small" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/456/logo?size=64",
                                                    "medium" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/456/logo?size=128",
                                                    "large" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/456/logo?size=256",
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
                                                },
                                              }])
    end

    xit "returns 404" do
      get "/api/eve/alliances/123/characters"

      expect(response).to have_http_status(:not_found)
    end
  end
end
