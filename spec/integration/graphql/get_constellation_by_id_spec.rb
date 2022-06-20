# frozen_string_literal: true

require "rails_helper"

describe "Get Constellation by ID" do
  let!(:eve_region) do
    create(:eve_region,
      region_id: 400)
  end

  let!(:eve_system) do
    create(:eve_system,
      system_id: 600,
      constellation: eve_constellation)
  end

  let!(:eve_constellation) do
    create(:eve_constellation,
      constellation_id: 123,
      name_en: "EN: name 1",
      name_de: "DE: name 1",
      name_fr: "FR: name 1",
      name_ja: "JA: name 1",
      name_ru: "RU: name 1",
      name_ko: "KO: name 1",
      region: eve_region)
  end

  let(:query) do
    %(
      query getConstellationByID {
        constellation(id: 123) {
          id
          name {
            en
            de
            fr
            ja
            ru
            ko
          }
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
      }
    )
  end

  let(:result) { EvemonkSchema.execute(query).as_json }

  specify do
    expect(result).to eq("data" => {
      "constellation" => {
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
      }
    })
  end
end
