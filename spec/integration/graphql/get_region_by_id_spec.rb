# frozen_string_literal: true

require "rails_helper"

describe "Get Region by ID" do
  let!(:eve_constellation) do
    create(:eve_constellation,
      id: 300,
      region: eve_region)
  end

  let!(:eve_contract) do
    create(:eve_contract,
      region: eve_region,
      contract_id: 1_123)
  end

  let!(:eve_region) do
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

  let(:query) do
    %(
      query getRegionByID {
        region(id: 123) {
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
      }
    )
  end

  let(:result) { EvemonkSchema.execute(query).as_json }

  specify do
    expect(result).to eq("data" => {
      "region" => {
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
      }
    })
  end
end
