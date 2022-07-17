# frozen_string_literal: true

require "rails_helper"

describe "Get Market Group by ID" do
  let!(:eve_type) do
    create(:eve_type,
      id: 400,
      market_group: eve_market_group)
  end

  let!(:eve_market_group) do
    create(:eve_market_group,
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
      parent_group_id: nil)
  end

  let(:query) do
    %(
      query getMarketGroupByID {
        marketGroup(id: 123) {
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
          parentGroupId
          parentGroup {
            id
          }
          types(first: 1) {
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
      "marketGroup" => {
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
        "parentGroupId" => nil,
        "parentGroup" => nil,
        "types" => {
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
        }
      }
    })
  end
end
