# frozen_string_literal: true

require "rails_helper"

describe Types::EveMarketGroupType do
  describe "get market groups" do
    let!(:eve_type1) do
      create(:eve_type,
        type_id: 400,
        market_group: eve_market_group1)
    end

    let!(:eve_type2) do
      create(:eve_type,
        type_id: 500,
        market_group: eve_market_group2)
    end

    let!(:eve_market_group1) do
      create(:eve_market_group,
        market_group_id: 123,
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

    let!(:eve_market_group2) do
      create(:eve_market_group,
        market_group_id: 321,
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
        description_ko: "KO: description 2",
        parent_group: eve_market_group1)
    end

    let(:query) do
      %(
        {
          marketGroups(first: 2) {
            edges {
              node {
                id
                name
                description
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
        "marketGroups" => {
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
                "parentGroupId" => 123,
                "parentGroup" => {
                  "id" => "123"
                },
                "types" => {
                  "edges" => [
                    {
                      "node" => {
                        "id" => "500"
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

  describe "get market group by id" do
    let!(:eve_type) do
      create(:eve_type,
        type_id: 400,
        market_group: eve_market_group)
    end

    let!(:eve_market_group) do
      create(:eve_market_group,
        market_group_id: 123,
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
        {
          marketGroup(id: 123) {
            id
            name
            description
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
end
