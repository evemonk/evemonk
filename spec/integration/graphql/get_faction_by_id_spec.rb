# frozen_string_literal: true

require "rails_helper"

describe "Get Faction by ID" do
  let!(:eve_corporation) do
    create(:eve_corporation,
      corporation_id: 1_111)
  end

  let!(:eve_militia_corporation) do
    create(:eve_corporation,
      corporation_id: 2_111)
  end

  let!(:eve_system) do
    create(:eve_system,
      system_id: 10_111)
  end

  let!(:eve_alliance) do
    create(:eve_alliance,
      id: 12_345,
      faction: eve_faction)
  end

  let!(:eve_faction) do
    create(:eve_faction,
      faction_id: 123,
      name_en: "EN: name 1",
      name_de: "DE: name 1",
      name_fr: "FR: name 1",
      name_ja: "JA: name 1",
      name_ru: "RU: name 1",
      name_ko: "KO: name 1",
      corporation: eve_corporation,
      description_en: "EN: description 1",
      description_de: "DE: description 1",
      description_fr: "FR: description 1",
      description_ja: "JA: description 1",
      description_ru: "RU: description 1",
      description_ko: "KO: description 1",
      is_unique: true,
      militia_corporation: eve_militia_corporation,
      solar_system: eve_system,
      station_count: 100,
      station_system_count: 1_000)
  end

  let(:query) do
    %(
      query getFactionByID {
        faction(id: 123) {
          id
          name {
            en
            de
            fr
            ja
            ru
            ko
          }
          description {
            en
            de
            fr
            ja
            ru
            ko
          }
          corporationId
          corporation {
            id
          }
          isUnique
          militiaCorporationId
          militiaCorporation {
            id
          }
          sizeFactor
          solarSystemId
          solarSystem {
            id
          }
          stationCount
          stationSystemCount
          alliances(first: 1) {
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
      "faction" => {
        "id" => "123",
        "name" => {
          "en" => "EN: name 1",
          "de" => "DE: name 1",
          "fr" => "FR: name 1",
          "ja" => "JA: name 1",
          "ru" => "RU: name 1",
          "ko" => "KO: name 1"
        },
        "description" => {
          "en" => "EN: description 1",
          "de" => "DE: description 1",
          "fr" => "FR: description 1",
          "ja" => "JA: description 1",
          "ru" => "RU: description 1",
          "ko" => "KO: description 1"
        },
        "corporationId" => 1_111,
        "corporation" => {
          "id" => "1111"
        },
        "isUnique" => true,
        "militiaCorporationId" => 2_111,
        "militiaCorporation" => {
          "id" => "2111"
        },
        "sizeFactor" => 1.5,
        "solarSystemId" => 10_111,
        "solarSystem" => {
          "id" => "10111"
        },
        "stationCount" => 100,
        "stationSystemCount" => 1_000,
        "alliances" => {
          "edges" => [
            {
              "node" => {
                "id" => "12345"
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
