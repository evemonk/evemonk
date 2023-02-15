# frozen_string_literal: true

require "rails_helper"

describe "Get Race by ID" do
  let!(:eve_faction) do
    create(:eve_faction,
      faction_id: 1_000_111)
  end

  let!(:eve_bloodline) do
    create(:eve_bloodline,
      id: 10,
      race: eve_race)
  end

  let!(:eve_station) do
    create(:eve_station,
      station_id: 100,
      race: eve_race)
  end

  let!(:eve_race) do
    create(:eve_race,
      id: 4,
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
      faction: eve_faction)
  end

  let(:query) do
    %(
      query getRaceByID {
        race(id: 4) {
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
          factionId
          faction {
            id
          }
          bloodlines(first: 1) {
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
          stations(first: 1) {
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
      "race" => {
        "id" => "4",
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
        "factionId" => 1_000_111,
        "faction" => {
          "id" => "1000111"
        },
        "bloodlines" => {
          "edges" => [
            {
              "node" => {
                "id" => "10"
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
        "stations" => {
          "edges" => [
            {
              "node" => {
                "id" => "100"
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
