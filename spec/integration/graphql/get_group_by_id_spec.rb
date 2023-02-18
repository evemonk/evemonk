# frozen_string_literal: true

require "rails_helper"

describe "Get Group by ID" do
  let!(:eve_category) do
    create(:eve_category,
      id: 1_111)
  end

  let!(:eve_type) do
    create(:eve_type,
      id: 10_111,
      group: eve_group)
  end

  let!(:eve_group) do
    create(:eve_group,
      id: 123,
      name_en: "EN: name 1",
      name_de: "DE: name 1",
      name_fr: "FR: name 1",
      name_ja: "JA: name 1",
      name_ru: "RU: name 1",
      name_ko: "KO: name 1",
      published: true,
      category: eve_category)
  end

  let(:query) do
    %(
      query getGroupByID {
        group(id: 123) {
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
      }
    )
  end

  let(:result) { EvemonkSchema.execute(query).as_json }

  specify do
    expect(result).to eq("data" => {
      "group" => {
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
      }
    })
  end
end
