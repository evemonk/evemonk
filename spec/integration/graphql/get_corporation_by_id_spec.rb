# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Get Corporation by ID" do
  before { freeze_time }

  let(:date_founded) { Time.zone.now }

  let!(:eve_alliance) do
    create(:eve_alliance,
      id: 1_111)
  end

  let!(:ceo) do
    create(:eve_character,
      id: 10_111)
  end

  let!(:creator) do
    create(:eve_character,
      id: 10_555)
  end

  let!(:eve_faction) do
    create(:eve_faction,
      id: 1_000_111)
  end

  let!(:eve_station) do
    create(:eve_station,
      station_id: 12_123_123)
  end

  let!(:eve_corporation) do
    create(:eve_corporation,
      id: 123,
      alliance: eve_alliance,
      ceo: ceo,
      creator: creator,
      date_founded: date_founded,
      description: "<b>Corp description 1</b>",
      faction: eve_faction,
      home_station: eve_station,
      member_count: 10,
      name: "Corp 1",
      shares: 101,
      tax_rate: 10.00,
      corporation_url: "https://url1.com/",
      war_eligible: true,
      npc: true)
  end

  let!(:eve_character) do
    create(:eve_character,
      id: 12_998,
      corporation: eve_corporation)
  end

  let(:query) do
    %(
      query getCorporationByID {
        corporation(id: 123) {
          id
          icon {
            tiny
            small
            medium
            large
          }
          iconTiny
          iconSmall
          iconMedium
          iconLarge
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
      }
    )
  end

  let(:result) { EvemonkSchema.execute(query).as_json }

  specify do
    expect(result).to eq("data" => {
      "corporation" => {
        "id" => "123",
        "icon" => {
          "tiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123/logo?size=32",
          "small" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123/logo?size=64",
          "medium" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123/logo?size=128",
          "large" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123/logo?size=256"
        },
        "iconTiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123/logo?size=32",
        "iconSmall" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123/logo?size=64",
        "iconMedium" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123/logo?size=128",
        "iconLarge" => "https://imageproxy.evemonk.com/https://images.evetech.net/corporations/123/logo?size=256",
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
        "dateFounded" => date_founded.iso8601,
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
      }
    })
  end
end
