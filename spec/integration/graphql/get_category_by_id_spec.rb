# frozen_string_literal: true

require "rails_helper"

describe "Get Category by ID" do
  let!(:eve_group) do
    create(:eve_group,
      id: 1_111,
      category: eve_category)
  end

  let!(:eve_category) do
    create(:eve_category,
      id: 123,
      name_en: "EN: name 1",
      name_de: "DE: name 1",
      name_fr: "FR: name 1",
      name_ja: "JA: name 1",
      name_ru: "RU: name 1",
      name_ko: "KO: name 1",
      published: true)
  end

  let(:query) do
    %(
      query getCategoryByID {
        category(id: 123) {
          id
          name {
            en
            de
            fr
            ja
            ru
            ko
          }
          published
          groups(first: 1) {
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
      "category" => {
        "id" => "123",
        "name" => {
          "en" => "EN: name 1",
          "de" => "DE: name 1",
          "fr" => "FR: name 1",
          "ja" => "JA: name 1",
          "ru" => "RU: name 1",
          "ko" => "KO: name 1"
        },
        "published" => true,
        "groups" => {
          "edges" => [
            {
              "node" => {
                "id" => "1111"
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
