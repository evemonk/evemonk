# frozen_string_literal: true

require "rails_helper"

describe Types::EveGroupType do
  describe "get groups" do
    let!(:eve_category1) do
      create(:eve_category,
        category_id: 1_111)
    end

    let!(:eve_category2) do
      create(:eve_category,
        category_id: 1_222)
    end

    let!(:eve_type1) do
      create(:eve_type,
        type_id: 10_111,
        group: eve_group1)
    end

    let!(:eve_type2) do
      create(:eve_type,
        type_id: 10_222,
        group: eve_group2)
    end

    let!(:eve_group1) do
      create(:eve_group,
        group_id: 123,
        name_en: "EN: name 1",
        name_de: "DE: name 1",
        name_fr: "FR: name 1",
        name_ja: "JA: name 1",
        name_ru: "RU: name 1",
        name_zh: "ZH: name 1",
        name_ko: "KO: name 1",
        published: true,
        category: eve_category1)
    end

    let!(:eve_group2) do
      create(:eve_group,
        group_id: 321,
        name_en: "EN: name 2",
        name_de: "DE: name 2",
        name_fr: "FR: name 2",
        name_ja: "JA: name 2",
        name_ru: "RU: name 2",
        name_zh: "ZH: name 2",
        name_ko: "KO: name 2",
        published: false,
        category: eve_category2)
    end

    let(:query) do
      %(
        {
          groups {
            id
            name
            published
            categoryId
            category {
              id
            }
            types {
              id
            }
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "groups" => [
          {
            "id" => "123",
            "name" => {
              "en" => "EN: name 1",
              "de" => "DE: name 1",
              "fr" => "FR: name 1",
              "ja" => "JA: name 1",
              "ru" => "RU: name 1",
              "zh" => "ZH: name 1",
              "ko" => "KO: name 1"
            },
            "published" => true,
            "categoryId" => 1_111,
            "category" => {
              "id" => "1111"
            },
            "types" => [
              {
                "id" => "10111"
              }
            ]
          },
          {
            "id" => "321",
            "name" => {
              "en" => "EN: name 2",
              "de" => "DE: name 2",
              "fr" => "FR: name 2",
              "ja" => "JA: name 2",
              "ru" => "RU: name 2",
              "zh" => "ZH: name 2",
              "ko" => "KO: name 2"
            },
            "published" => false,
            "categoryId" => 1_222,
            "category" => {
              "id" => "1222"
            },
            "types" => [
              {
                "id" => "10222"
              }
            ]
          }
        ]
      })
    end
  end

  describe "get group by id" do
    let!(:eve_category) do
      create(:eve_category,
        category_id: 1_111)
    end

    let!(:eve_type) do
      create(:eve_type,
        type_id: 10_111,
        group: eve_group)
    end

    let!(:eve_group) do
      create(:eve_group,
        group_id: 123,
        name_en: "EN: name 1",
        name_de: "DE: name 1",
        name_fr: "FR: name 1",
        name_ja: "JA: name 1",
        name_ru: "RU: name 1",
        name_zh: "ZH: name 1",
        name_ko: "KO: name 1",
        published: true,
        category: eve_category)
    end

    let(:query) do
      %(
        {
          group(id: 123) {
            id
            name
            published
            categoryId
            category {
              id
            }
            types {
              id
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
            "zh" => "ZH: name 1",
            "ko" => "KO: name 1"
          },
          "published" => true,
          "categoryId" => 1_111,
          "category" => {
            "id" => "1111"
          },
          "types" => [
            {
              "id" => "10111"
            }
          ]
        }
      })
    end
  end
end
