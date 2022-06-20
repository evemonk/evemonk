# frozen_string_literal: true

require "rails_helper"

describe "Get Constellations" do
  let!(:eve_region_1) do
    create(:eve_region,
      region_id: 400)
  end

  let!(:eve_region_2) do
    create(:eve_region,
      region_id: 500)
  end

  let!(:eve_system_1) do
    create(:eve_system,
      system_id: 600,
      constellation: eve_constellation_1)
  end

  let!(:eve_system_2) do
    create(:eve_system,
      system_id: 700,
      constellation: eve_constellation_2)
  end

  let!(:eve_constellation_1) do
    create(:eve_constellation,
      constellation_id: 123,
      name_en: "EN: name 1",
      name_de: "DE: name 1",
      name_fr: "FR: name 1",
      name_ja: "JA: name 1",
      name_ru: "RU: name 1",
      name_ko: "KO: name 1",
      region: eve_region_1)
  end

  let!(:eve_constellation_2) do
    create(:eve_constellation,
      constellation_id: 321,
      name_en: "EN: name 2",
      name_de: "DE: name 2",
      name_fr: "FR: name 2",
      name_ja: "JA: name 2",
      name_ru: "RU: name 2",
      name_ko: "KO: name 2",
      region: eve_region_2)
  end

  let(:query) do
    %(
      query getConstellations {
        constellations(first: 2) {
          edges {
            node {
              id
              name
              regionId
              region {
                id
              }
              systems(first: 1) {
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
      "constellations" => {
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
              "regionId" => 400,
              "region" => {
                "id" => "400"
              },
              "systems" => {
                "edges" => [
                  {
                    "node" => {
                      "id" => "600"
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
              "regionId" => 500,
              "region" => {
                "id" => "500"
              },
              "systems" => {
                "edges" => [
                  {
                    "node" => {
                      "id" => "700"
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
