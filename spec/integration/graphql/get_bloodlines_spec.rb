# frozen_string_literal: true

require "rails_helper"

describe "Get Bloodlines" do
  let!(:eve_corporation_1) do
    create(:eve_corporation,
      corporation_id: 500)
  end

  let!(:eve_corporation_2) do
    create(:eve_corporation,
      corporation_id: 600)
  end

  let!(:eve_race_1) do
    create(:eve_race,
      id: 4)
  end

  let!(:eve_race_2) do
    create(:eve_race,
      id: 8)
  end

  let!(:eve_ship_type_1) do
    create(:eve_ship,
      type_id: 1_001)
  end

  let!(:eve_ship_type_2) do
    create(:eve_ship,
      type_id: 1_002)
  end

  let!(:eve_ancestry_1) do
    create(:eve_ancestry,
      id: 10_001,
      bloodline: eve_bloodline_1)
  end

  let!(:eve_ancestry_2) do
    create(:eve_ancestry,
      id: 10_002,
      bloodline: eve_bloodline_2)
  end

  let!(:eve_bloodline_1) do
    create(:eve_bloodline,
      id: 123,
      name_en: "EN: name 1",
      name_de: "DE: name 1",
      name_fr: "FR: name 1",
      name_ja: "JA: name 1",
      name_ru: "RU: name 1",
      name_ko: "KO: name 1",
      description_en: "EN: description 1",
      description_de: "DE: description 1",
      description_fr: "FR: description 1",
      description_ja: "JA: description 1",
      description_ru: "RU: description 1",
      description_ko: "KO: description 1",
      corporation: eve_corporation_1,
      race: eve_race_1,
      ship_type: eve_ship_type_1,
      charisma: 1,
      intelligence: 2,
      memory: 3,
      perception: 4,
      willpower: 5)
  end

  let!(:eve_bloodline_2) do
    create(:eve_bloodline,
      id: 321,
      name_en: "EN: name 2",
      name_de: "DE: name 2",
      name_fr: "FR: name 2",
      name_ja: "JA: name 2",
      name_ru: "RU: name 2",
      name_ko: "KO: name 2",
      description_en: "EN: description 2",
      description_de: "DE: description 2",
      description_fr: "FR: description 2",
      description_ja: "JA: description 2",
      description_ru: "RU: description 2",
      description_ko: "KO: description 2",
      corporation: eve_corporation_2,
      race: eve_race_2,
      ship_type: eve_ship_type_2,
      charisma: 6,
      intelligence: 7,
      memory: 8,
      perception: 9,
      willpower: 10)
  end

  let(:query) do
    %(
      query getBloodlines {
        bloodlines(first: 2) {
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
              raceId
              race {
                id
              }
              shipTypeId
              shipType {
                id
              }
              charisma
              intelligence
              memory
              perception
              willpower
              ancestries(first: 1) {
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
      "bloodlines" => {
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
              "corporationId" => 500,
              "corporation" => {
                "id" => "500"
              },
              "raceId" => 4,
              "race" => {
                "id" => "4"
              },
              "shipTypeId" => 1_001,
              "shipType" => {
                "id" => "1001"
              },
              "charisma" => 1,
              "intelligence" => 2,
              "memory" => 3,
              "perception" => 4,
              "willpower" => 5,
              "ancestries" => {
                "edges" => [
                  {
                    "node" => {
                      "id" => "10001"
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
              "name" => {
                "en" => "EN: name 2",
                "de" => "DE: name 2",
                "fr" => "FR: name 2",
                "ja" => "JA: name 2",
                "ru" => "RU: name 2",
                "ko" => "KO: name 2"
              },
              "description" => {
                "en" => "EN: description 2",
                "de" => "DE: description 2",
                "fr" => "FR: description 2",
                "ja" => "JA: description 2",
                "ru" => "RU: description 2",
                "ko" => "KO: description 2"
              },
              "corporationId" => 600,
              "corporation" => {
                "id" => "600"
              },
              "raceId" => 8,
              "race" => {
                "id" => "8"
              },
              "shipTypeId" => 1_002,
              "shipType" => {
                "id" => "1002"
              },
              "charisma" => 6,
              "intelligence" => 7,
              "memory" => 8,
              "perception" => 9,
              "willpower" => 10,
              "ancestries" => {
                "edges" => [
                  {
                    "node" => {
                      "id" => "10002"
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
