# frozen_string_literal: true

require "rails_helper"

describe Api::CharactersController do
  before { Setting.use_image_proxy = true }

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
                                                  "tiny" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123123123_32.jpg",
                                                  "small" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123123123_64.jpg",
                                                  "medium" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123123123_128.jpg",
                                                  "large" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123123123_256.jpg",
                                                  "huge" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123123123_512.jpg",
                                                  "gigantic" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123123123_1024.jpg",
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

      create(:character,
        user: user,
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
        title: "Character title",
        charisma: 20,
        intelligence: 21,
        memory: 22,
        perception: 23,
        willpower: 24,
        wallet: 123_252.49,
        bonus_remaps: 2,
        last_remap_date: "2011-05-07T12:58:06Z",
        accrued_remap_cooldown_date: "2012-05-06T12:58:06Z")

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

      get "/api/characters/123123123", headers: {'Authorization': "Bearer #{session.token}"}

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body)).to eq("id" => 123_123_123,
                                              "icon" => {
                                                "tiny" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123123123_32.jpg",
                                                "small" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123123123_64.jpg",
                                                "medium" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123123123_128.jpg",
                                                "large" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123123123_256.jpg",
                                                "huge" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123123123_512.jpg",
                                                "gigantic" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Character/123123123_1024.jpg",
                                              },
                                              "name" => "Character name",
                                              "description" => "Character description",
                                              "birthday" => "2015-05-03T19:45:17Z",
                                              "gender" => "male",
                                              "security_status" => "1.1",
                                              "perception" => 23,
                                              "memory" => 22,
                                              "willpower" => 24,
                                              "intelligence" => 21,
                                              "charisma" => 20,
                                              "wallet" => 123_252,
                                              "bonus_remaps" => 2,
                                              "last_remap_date" => "2011-05-07T12:58:06Z",
                                              "accrued_remap_cooldown_date" => "2012-05-06T12:58:06Z",
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
                                              "corporation" => {
                                                "id" => 456,
                                                "icon" => {
                                                  "tiny" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Corporation/456_32.png",
                                                  "small" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Corporation/456_64.png",
                                                  "medium" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Corporation/456_128.png",
                                                  "large" => "https://imageproxy.evemonk.com/https://imageserver.eveonline.com/Corporation/456_256.png",
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
                                              })
    end
  end
end
