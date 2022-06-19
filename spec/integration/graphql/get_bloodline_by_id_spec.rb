# frozen_string_literal: true

require "rails_helper"

describe "Get Bloodline By ID" do
  let!(:eve_corporation) do
    create(:eve_corporation,
      corporation_id: 500)
  end

  let!(:eve_race) do
    create(:eve_race,
      race_id: 4)
  end

  let!(:eve_ship_type) do
    create(:eve_ship,
      type_id: 1_001)
  end

  let!(:eve_ancestry) do
    create(:eve_ancestry,
      ancestry_id: 10_001,
      bloodline: eve_bloodline)
  end

  let!(:eve_bloodline) do
    create(:eve_bloodline,
      bloodline_id: 123,
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
      corporation: eve_corporation,
      race: eve_race,
      ship_type: eve_ship_type,
      charisma: 1,
      intelligence: 2,
      memory: 3,
      perception: 4,
      willpower: 5)
  end

  let(:query) do
    %(
      query getBloodlineByID {
        bloodline(id: 123) {
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
      }
    )
  end

  let(:result) { EvemonkSchema.execute(query).as_json }

  specify do
    expect(result).to eq("data" => {
      "bloodline" => {
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
            "node" => {
              "id" => "10001"
            },
            "cursor" => "MQ"
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
