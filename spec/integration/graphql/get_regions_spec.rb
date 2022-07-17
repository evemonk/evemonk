# frozen_string_literal: true

require "rails_helper"

describe "Get Regions" do
  let!(:eve_constellation_1) do
    create(:eve_constellation,
      id: 300,
      region: eve_region_1)
  end

  let!(:eve_constellation_2) do
    create(:eve_constellation,
      id: 400,
      region: eve_region_2)
  end

  let!(:eve_contract_1) do
    create(:eve_contract,
      region: eve_region_1,
      contract_id: 1_123)
  end

  let!(:eve_contract_2) do
    create(:eve_contract,
      region: eve_region_2,
      contract_id: 1_124)
  end

  let!(:eve_region_1) do
    create(:eve_region,
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
      description_ko: "KO: description 1")
  end

  let!(:eve_region_2) do
    create(:eve_region,
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
      description_ko: "KO: description 2")
  end

  let(:query) do
    %(
      query getRegions {
        regions(first: 2) {
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
              constellations(first: 1) {
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
              contracts(first: 1) {
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
      "regions" => {
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
              "constellations" => {
                "edges" => [
                  {
                    "node" => {
                      "id" => "300"
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
              "contracts" => {
                "edges" => [
                  {
                    "node" => {
                      "id" => "1123"
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
              "constellations" => {
                "edges" => [
                  {
                    "node" => {
                      "id" => "400"
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
              "contracts" => {
                "edges" => [
                  {
                    "node" => {
                      "id" => "1124"
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
