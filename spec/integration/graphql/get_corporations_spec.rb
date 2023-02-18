# frozen_string_literal: true

require "rails_helper"

describe "Get Corporations" do
  before { freeze_time }

  let(:date_founded_1) { Time.zone.now }

  let(:date_founded_2) { 1.week.ago }

  let!(:eve_alliance_1) do
    create(:eve_alliance,
      id: 1_111)
  end

  let!(:eve_alliance_2) do
    create(:eve_alliance,
      id: 1_222)
  end

  let!(:ceo_1) do
    create(:eve_character,
      id: 10_111)
  end

  let!(:ceo_2) do
    create(:eve_character,
      id: 10_222)
  end

  let!(:creator_1) do
    create(:eve_character,
      id: 10_555)
  end

  let!(:creator_2) do
    create(:eve_character,
      id: 10_666)
  end

  let!(:eve_faction_1) do
    create(:eve_faction,
      id: 1_000_111)
  end

  let!(:eve_faction_2) do
    create(:eve_faction,
      id: 1_000_222)
  end

  let!(:eve_station_1) do
    create(:eve_station,
      id: 12_123_123)
  end

  let!(:eve_station_2) do
    create(:eve_station,
      id: 12_321_321)
  end

  let!(:eve_corporation_1) do
    create(:eve_corporation,
      id: 123,
      alliance: eve_alliance_1,
      ceo: ceo_1,
      creator: creator_1,
      date_founded: date_founded_1,
      description: "<b>Corp description 1</b>",
      faction: eve_faction_1,
      home_station: eve_station_1,
      member_count: 10,
      name: "Corp 1",
      shares: 101,
      tax_rate: 10.00,
      corporation_url: "https://url1.com/",
      war_eligible: true,
      npc: true)
  end

  let!(:eve_corporation_2) do
    create(:eve_corporation,
      id: 321,
      alliance: eve_alliance_2,
      ceo: ceo_2,
      creator: creator_2,
      date_founded: date_founded_2,
      description: "<b>Corp description 2</b>",
      faction: eve_faction_2,
      home_station: eve_station_2,
      member_count: 100,
      name: "Corp 2",
      shares: 102,
      tax_rate: 20.00,
      corporation_url: "https://url2.com/",
      war_eligible: false,
      npc: false)
  end

  let!(:eve_character_1) do
    create(:eve_character,
      id: 12_998,
      corporation: eve_corporation_1)
  end

  let!(:eve_character_2) do
    create(:eve_character,
      id: 12_999,
      corporation: eve_corporation_2)
  end

  let(:query) do
    %(
      query getCorporations {
        corporations(first: 2) {
          edges {
            node {
              id
              icon {
                tiny
                small
                medium
                large
              }
              allianceId
              alliance {
                id
              }
              ceoId
              ceo {
                id
              }
              creatorId
              creator {
                id
              }
              dateFounded
              description
              factionId
              faction {
                id
              }
              homeStationId
              homeStation {
                id
              }
              memberCount
              name
              shares
              taxRate
              ticker
              url
              warEligible
              npc
              characters(first: 1) {
                edges {
                  node {
                    id
                  }
                  cursor
                }
                pageInfo {
                  endCursor
                  hasNextPage
                  hasPreviousPage
                  startCursor
                }
              }
            }
            cursor
          }
          pageInfo {
            endCursor
            hasNextPage
            hasPreviousPage
            startCursor
          }
        }
      }
    )
  end

  let(:result) { EvemonkSchema.execute(query).as_json }

  specify do
    expect(result).to eq("data" => {
      "corporations" => {
        "edges" => [
          {
            "node" => {
              "id" => "123",
              "icon" => {
                "tiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123/logo?size=32",
                "small" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123/logo?size=64",
                "medium" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123/logo?size=128",
                "large" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123/logo?size=256"
              },
              "allianceId" => 1_111,
              "alliance" => {
                "id" => "1111"
              },
              "ceoId" => 10_111,
              "ceo" => {
                "id" => "10111"
              },
              "creatorId" => 10_555,
              "creator" => {
                "id" => "10555"
              },
              "dateFounded" => date_founded_1.iso8601,
              "description" => "Corp description 1",
              "factionId" => 1_000_111,
              "faction" => {
                "id" => "1000111"
              },
              "homeStationId" => 12_123_123,
              "homeStation" => {
                "id" => "12123123"
              },
              "memberCount" => 10,
              "name" => "Corp 1",
              "shares" => "101",
              "taxRate" => 10.0,
              "ticker" => "CORP 1",
              "url" => "https://url1.com/",
              "warEligible" => true,
              "npc" => true,
              "characters" => {
                "edges" => [
                  {
                    "node" => {
                      "id" => "12998"
                    },
                    "cursor" => "MQ"
                  }
                ],
                "pageInfo" => {
                  "endCursor" => "MQ",
                  "hasNextPage" => false,
                  "hasPreviousPage" => false,
                  "startCursor" => "MQ"
                }
              }
            },
            "cursor" => "MQ"
          },
          {
            "node" => {
              "id" => "321",
              "icon" => {
                "tiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/321/logo?size=32",
                "small" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/321/logo?size=64",
                "medium" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/321/logo?size=128",
                "large" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/321/logo?size=256"
              },
              "allianceId" => 1_222,
              "alliance" => {
                "id" => "1222"
              },
              "ceoId" => 10_222,
              "ceo" => {
                "id" => "10222"
              },
              "creatorId" => 10_666,
              "creator" => {
                "id" => "10666"
              },
              "dateFounded" => date_founded_2.iso8601,
              "description" => "Corp description 2",
              "factionId" => 1_000_222,
              "faction" => {
                "id" => "1000222"
              },
              "homeStationId" => 12_321_321,
              "homeStation" => {
                "id" => "12321321"
              },
              "memberCount" => 100,
              "name" => "Corp 2",
              "shares" => "102",
              "taxRate" => 20.0,
              "ticker" => "CORP 2",
              "url" => "https://url2.com/",
              "warEligible" => false,
              "npc" => false,
              "characters" => {
                "edges" => [
                  {
                    "node" => {
                      "id" => "12999"
                    },
                    "cursor" => "MQ"
                  }
                ],
                "pageInfo" => {
                  "endCursor" => "MQ",
                  "hasNextPage" => false,
                  "hasPreviousPage" => false,
                  "startCursor" => "MQ"
                }
              }
            },
            "cursor" => "Mg"
          }
        ],
        "pageInfo" => {
          "endCursor" => "Mg",
          "hasNextPage" => false,
          "hasPreviousPage" => false,
          "startCursor" => "MQ"
        }
      }
    })
  end
end
