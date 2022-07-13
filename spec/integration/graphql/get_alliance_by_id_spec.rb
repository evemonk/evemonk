# frozen_string_literal: true

require "rails_helper"

describe "Get Alliance by ID" do
  before { travel_to Time.zone.now }

  let(:date_founded) { Time.zone.now }

  let!(:creator_corporation) do
    create(:eve_corporation,
      corporation_id: 222)
  end

  let!(:executor_corporation) do
    create(:eve_corporation,
      corporation_id: 444)
  end

  let!(:creator) do
    create(:eve_character,
      character_id: 4_444)
  end

  let!(:eve_faction) do
    create(:eve_faction,
      faction_id: 10_111)
  end

  let!(:eve_alliance) do
    create(:eve_alliance,
      alliance_id: 123,
      name: "Alliance 1",
      ticker: "ALLIANCE1",
      date_founded: date_founded,
      creator_corporation: creator_corporation,
      creator: creator,
      executor_corporation: executor_corporation,
      faction: eve_faction)
  end

  let!(:eve_corporation) do
    create(:eve_corporation,
      corporation_id: 100_111,
      alliance: eve_alliance,
      member_count: 1)
  end

  let!(:eve_character) do
    create(:eve_character,
      corporation: eve_corporation,
      character_id: 111_111)
  end

  let(:query) do
    %(
      query getAllianceByID {
        alliance(id: 123) {
          id
          name
          ticker
          icon {
            tiny
            small
            medium
            large
            huge
          }
          dateFounded
          creatorCorporationId
          creatorCorporation {
            id
          }
          creatorId
          creator {
            id
          }
          executorCorporationId
          executorCorporation {
            id
          }
          factionId
          faction {
            id
          }
          corporationsCount
          charactersCount
          corporations(first: 1) {
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
      "alliance" => {
        "id" => "123",
        "name" => "Alliance 1",
        "ticker" => "ALLIANCE1",
        "icon" => {
          "tiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/alliances/123/logo?size=32",
          "small" => "https://imageproxy.evemonk.com/https://images.evetech.net/alliances/123/logo?size=64",
          "medium" => "https://imageproxy.evemonk.com/https://images.evetech.net/alliances/123/logo?size=128",
          "large" => "https://imageproxy.evemonk.com/https://images.evetech.net/alliances/123/logo?size=256",
          "huge" => "https://imageproxy.evemonk.com/https://images.evetech.net/alliances/123/logo?size=512"
        },
        "dateFounded" => date_founded.iso8601,
        "creatorCorporationId" => 222,
        "creatorCorporation" => {
          "id" => "222"
        },
        "creatorId" => 4444,
        "creator" => {
          "id" => "4444"
        },
        "executorCorporationId" => 444,
        "executorCorporation" => {
          "id" => "444"
        },
        "factionId" => 10_111,
        "faction" => {
          "id" => "10111"
        },
        "corporationsCount" => 1,
        "charactersCount" => 1,
        "corporations" => {
          "edges" => [
            {
              "node" => {
                "id" => "100111"
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
        },
        "characters" => {
          "edges" => [
            {
              "node" => {
                "id" => "111111"
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
