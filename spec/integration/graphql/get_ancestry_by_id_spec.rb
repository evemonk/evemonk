# frozen_string_literal: true

require "rails_helper"

describe "Get Ancestry by ID" do
  let!(:eve_bloodline) do
    create(:eve_bloodline,
      id: 10)
  end

  let!(:eve_icon) do
    create(:eve_icon,
      icon_id: 1_001)
  end

  let!(:eve_ancestry) do
    create(:eve_ancestry,
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
      short_description: "Short description 1",
      bloodline: eve_bloodline,
      icon: eve_icon)
  end

  let(:query) do
    %(
      query getAncestryByID {
        ancestry(id: 123) {
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
