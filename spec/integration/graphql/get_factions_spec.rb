# frozen_string_literal: true

require "rails_helper"

describe "Get Factions" do
  let!(:eve_corporation_1) do
    create(:eve_corporation,
      id: 1_111)
  end

  let!(:eve_corporation_2) do
    create(:eve_corporation,
      id: 1_222)
  end

  let!(:eve_militia_corporation_1) do
    create(:eve_corporation,
      id: 2_111)
  end

  let!(:eve_militia_corporation_2) do
    create(:eve_corporation,
      id: 2_222)
  end

  let!(:eve_system_1) do
    create(:eve_system,
      system_id: 10_111)
  end

  let!(:eve_system_2) do
    create(:eve_system,
      system_id: 10_222)
  end

  let!(:eve_alliance_1) do
    create(:eve_alliance,
      id: 12_345,
      faction: eve_faction_1)
  end

  let!(:eve_alliance_2) do
    create(:eve_alliance,
      id: 67_890,
      faction: eve_faction_2)
  end

  let!(:eve_faction_1) do
    create(:eve_faction,
      id: 123,
      name_en: "EN: name 1",
      name_de: "DE: name 1",
      name_fr: "FR: name 1",
      name_ja: "JA: name 1",
      name_ru: "RU: name 1",
      name_ko: "KO: name 1",
      corporation: eve_corporation_1,
      description_en: "EN: description 1",
      description_de: "DE: description 1",
      description_fr: "FR: description 1",
      description_ja: "JA: description 1",
      description_ru: "RU: description 1",
      description_ko: "KO: description 1",
      is_unique: true,
      militia_corporation: eve_militia_corporation_1,
      solar_system: eve_system_1,
      station_count: 100,
      station_system_count: 1_000)
  end

  let!(:eve_faction_2) do
    create(:eve_faction,
      id: 321,
      name_en: "EN: name 2",
      name_de: "DE: name 2",
      name_fr: "FR: name 2",
      name_ja: "JA: name 2",
      name_ru: "RU: name 2",
      name_ko: "KO: name 2",
      corporation: eve_corporation_2,
      description_en: "EN: description 2",
      description_de: "DE: description 2",
      description_fr: "FR: description 2",
      description_ja: "JA: description 2",
      description_ru: "RU: description 2",
      description_ko: "KO: description 2",
      is_unique: false,
      militia_corporation: eve_militia_corporation_2,
      solar_system: eve_system_2,
      station_count: 200,
      station_system_count: 2_000)
  end

  let(:query) do
    %(
      query getFactions {
        factions(first: 2) {
          edges {
            node {
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
      "factions" => {
        "edges" => [
          {
            "node" => {
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
            },
            "cursor" => "MQ"
          },
          {
            "node" => {
              "id" => "321",
              "corporationId" => 1_222,
              "corporation" => {
                "id" => "1222"
              },
              "description" => {
                "en" => "EN: description 2",
                "de" => "DE: description 2",
                "fr" => "FR: description 2",
                "ja" => "JA: description 2",
                "ru" => "RU: description 2",
                "ko" => "KO: description 2"
              },
              "isUnique" => false,
              "name" => {
                "en" => "EN: name 2",
                "de" => "DE: name 2",
                "fr" => "FR: name 2",
                "ja" => "JA: name 2",
                "ru" => "RU: name 2",
                "ko" => "KO: name 2"
              },
              "militiaCorporationId" => 2_222,
              "militiaCorporation" => {
                "id" => "2222"
              },
              "sizeFactor" => 1.5,
              "solarSystemId" => 10_222,
              "solarSystem" => {
                "id" => "10222"
              },
              "stationCount" => 200,
              "stationSystemCount" => 2_000,
              "alliances" => {
                "edges" => [
                  {
                    "node" => {
                      "id" => "67890"
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
