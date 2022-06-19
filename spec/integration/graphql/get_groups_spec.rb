# frozen_string_literal: true

require "rails_helper"

describe "Get Groups" do
  let!(:eve_category_1) do
    create(:eve_category,
      category_id: 1_111)
  end

  let!(:eve_category_2) do
    create(:eve_category,
      category_id: 1_222)
  end

  let!(:eve_type_1) do
    create(:eve_type,
      type_id: 10_111,
      group: eve_group_1)
  end

  let!(:eve_type_2) do
    create(:eve_type,
      type_id: 10_222,
      group: eve_group_2)
  end

  let!(:eve_group_1) do
    create(:eve_group,
      group_id: 123,
      name_en: "EN: name 1",
      name_de: "DE: name 1",
      name_fr: "FR: name 1",
      name_ja: "JA: name 1",
      name_ru: "RU: name 1",
      name_ko: "KO: name 1",
      published: true,
      category: eve_category_1)
  end

  let!(:eve_group_2) do
    create(:eve_group,
      group_id: 321,
      name_en: "EN: name 2",
      name_de: "DE: name 2",
      name_fr: "FR: name 2",
      name_ja: "JA: name 2",
      name_ru: "RU: name 2",
      name_ko: "KO: name 2",
      published: false,
      category: eve_category_2)
  end

  let(:query) do
    %(
      query getGroups {
        groups(first: 2) {
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
              published
              categoryId
              category {
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
      "groups" => {
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
              "published" => true,
              "categoryId" => 1_111,
              "category" => {
                "id" => "1111"
              },
              "types" => {
                "edges" => [
                  {
                    "node" => {
                      "id" => "10111"
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
              "published" => false,
              "categoryId" => 1_222,
              "category" => {
                "id" => "1222"
              },
              "types" => {
                "edges" => [
                  {
                    "node" => {
                      "id" => "10222"
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
