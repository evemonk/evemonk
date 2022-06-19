# frozen_string_literal: true

require "rails_helper"

describe Types::EveAncestryType do
  describe "get ancestries" do
    let!(:eve_bloodline_1) do
      create(:eve_bloodline,
        bloodline_id: 10)
    end

    let!(:eve_bloodline_2) do
      create(:eve_bloodline,
        bloodline_id: 20)
    end

    let!(:eve_icon_1) do
      create(:eve_icon,
        icon_id: 1_001)
    end

    let!(:eve_icon_2) do
      create(:eve_icon,
        icon_id: 1_002)
    end

    let!(:eve_ancestry_1) do
      create(:eve_ancestry,
        ancestry_id: 123,
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
        short_description: "Short description 1",
        bloodline: eve_bloodline_1,
        icon: eve_icon_1)
    end

    let!(:eve_ancestry_2) do
      create(:eve_ancestry,
        ancestry_id: 321,
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
        short_description: "Short description 2",
        bloodline: eve_bloodline_2,
        icon: eve_icon_2)
    end

    let(:query) do
      %(
        {
          ancestries(first: 2) {
            edges {
              node {
                id
                name
                description
                bloodlineId
                bloodline {
                  id
                }
                iconId
                icon {
                  id
                }
                shortDescription
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
        "ancestries" => {
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
                "bloodlineId" => 10,
                "bloodline" => {
                  "id" => "10"
                },
                "iconId" => 1_001,
                "icon" => {
                  "id" => "1001"
                },
                "shortDescription" => "Short description 1"
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
                "bloodlineId" => 20,
                "bloodline" => {
                  "id" => "20"
                },
                "iconId" => 1_002,
                "icon" => {
                  "id" => "1002"
                },
                "shortDescription" => "Short description 2"
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

  describe "get ancestry by id" do
    let!(:eve_bloodline) do
      create(:eve_bloodline,
        bloodline_id: 10)
    end

    let!(:eve_icon) do
      create(:eve_icon,
        icon_id: 1_001)
    end

    let!(:eve_ancestry) do
      create(:eve_ancestry,
        ancestry_id: 123,
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
        short_description: "Short description 1",
        bloodline: eve_bloodline,
        icon: eve_icon)
    end

    let(:query) do
      %(
        {
          ancestry(id: 123) {
            id
            name
            description
            bloodlineId
            bloodline {
              id
            }
            iconId
            icon {
              id
            }
            shortDescription
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "ancestry" => {
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
          "bloodlineId" => 10,
          "bloodline" => {
            "id" => "10"
          },
          "iconId" => 1_001,
          "icon" => {
            "id" => "1001"
          },
          "shortDescription" => "Short description 1"
        }
      })
    end
  end
end
