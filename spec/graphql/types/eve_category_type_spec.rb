# frozen_string_literal: true

require "rails_helper"

describe Types::EveCategoryType do
  describe "get categories" do
    let!(:eve_group1) do
      create(:eve_group,
        group_id: 1_111,
        category: eve_category1)
    end

    let!(:eve_group2) do
      create(:eve_group,
        group_id: 1_222,
        category: eve_category2)
    end

    let!(:eve_category1) do
      create(:eve_category,
        category_id: 123,
        name_en: "EN: name 1",
        name_de: "DE: name 1",
        name_fr: "FR: name 1",
        name_ja: "JA: name 1",
        name_ru: "RU: name 1",
        name_ko: "KO: name 1",
        published: true)
    end

    let!(:eve_category2) do
      create(:eve_category,
        category_id: 321,
        name_en: "EN: name 2",
        name_de: "DE: name 2",
        name_fr: "FR: name 2",
        name_ja: "JA: name 2",
        name_ru: "RU: name 2",
        name_ko: "KO: name 2",
        published: false)
    end

    let(:query) do
      %(
        {
          categories(first: 2) {
            edges {
              node {
                id
                name
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
        "categories" => {
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
                "groups" => {
                  "edges" => [
                    {
                      "node" => {
                        "id" => "1222"
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

  describe "get category by id" do
    let!(:eve_group) do
      create(:eve_group,
        group_id: 1_111,
        category: eve_category)
    end

    let!(:eve_category) do
      create(:eve_category,
        category_id: 123,
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
        {
          category(id: 123) {
            id
            name
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
end
