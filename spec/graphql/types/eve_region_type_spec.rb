# frozen_string_literal: true

require "rails_helper"

describe Types::EveRegionType do
  describe "get regions" do
    let!(:eve_constellation1) do
      create(:eve_constellation,
        constellation_id: 300,
        region: eve_region1)
    end

    let!(:eve_constellation2) do
      create(:eve_constellation,
        constellation_id: 400,
        region: eve_region2)
    end

    let!(:eve_contract1) do
      create(:eve_contract,
        region: eve_region1,
        contract_id: 1_123)
    end

    let!(:eve_contract2) do
      create(:eve_contract,
        region: eve_region2,
        contract_id: 1_124)
    end

    let!(:eve_region1) do
      create(:eve_region,
        region_id: 123,
        name_en: "EN: name 1",
        name_de: "DE: name 1",
        name_fr: "FR: name 1",
        name_ja: "JA: name 1",
        name_ru: "RU: name 1",
        name_zh: "ZH: name 1",
        name_ko: "KO: name 1",
        description_en: "EN: description 1",
        description_de: "DE: description 1",
        description_fr: "FR: description 1",
        description_ja: "JA: description 1",
        description_ru: "RU: description 1",
        description_zh: "ZH: description 1",
        description_ko: "KO: description 1")
    end

    let!(:eve_region2) do
      create(:eve_region,
        region_id: 321,
        name_en: "EN: name 2",
        name_de: "DE: name 2",
        name_fr: "FR: name 2",
        name_ja: "JA: name 2",
        name_ru: "RU: name 2",
        name_zh: "ZH: name 2",
        name_ko: "KO: name 2",
        description_en: "EN: description 2",
        description_de: "DE: description 2",
        description_fr: "FR: description 2",
        description_ja: "JA: description 2",
        description_ru: "RU: description 2",
        description_zh: "ZH: description 2",
        description_ko: "KO: description 2")
    end

    let(:query) do
      %(
        {
          regions {
            id
            name
            description
            constellations {
              id
            }
            contracts {
              id
            }
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "regions" => [
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
            "description" => {
              "en" => "EN: description 1",
              "de" => "DE: description 1",
              "fr" => "FR: description 1",
              "ja" => "JA: description 1",
              "ru" => "RU: description 1",
              "zh" => "ZH: description 1",
              "ko" => "KO: description 1"
            },
            "constellations" => [
              {
                "id" => "300"
              }
            ],
            "contracts" => [
              {
                "id" => "1123"
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
            "description" => {
              "en" => "EN: description 2",
              "de" => "DE: description 2",
              "fr" => "FR: description 2",
              "ja" => "JA: description 2",
              "ru" => "RU: description 2",
              "zh" => "ZH: description 2",
              "ko" => "KO: description 2"
            },
            "constellations" => [
              {
                "id" => "400"
              }
            ],
            "contracts" => [
              {
                "id" => "1124"
              }
            ]
          }
        ]
      })
    end
  end

  describe "get region by id" do
    let!(:eve_constellation) do
      create(:eve_constellation,
        constellation_id: 300,
        region: eve_region)
    end

    let!(:eve_contract) do
      create(:eve_contract,
        region: eve_region,
        contract_id: 1_123)
    end

    let!(:eve_region) do
      create(:eve_region,
        region_id: 123,
        name_en: "EN: name 1",
        name_de: "DE: name 1",
        name_fr: "FR: name 1",
        name_ja: "JA: name 1",
        name_ru: "RU: name 1",
        name_zh: "ZH: name 1",
        name_ko: "KO: name 1",
        description_en: "EN: description 1",
        description_de: "DE: description 1",
        description_fr: "FR: description 1",
        description_ja: "JA: description 1",
        description_ru: "RU: description 1",
        description_zh: "ZH: description 1",
        description_ko: "KO: description 1")
    end

    let(:query) do
      %(
        {
          region(id: 123) {
            id
            name
            description
            constellations {
              id
            }
            contracts {
              id
            }
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "region" => {
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
          "description" => {
            "en" => "EN: description 1",
            "de" => "DE: description 1",
            "fr" => "FR: description 1",
            "ja" => "JA: description 1",
            "ru" => "RU: description 1",
            "zh" => "ZH: description 1",
            "ko" => "KO: description 1"
          },
          "constellations" => [
            {
              "id" => "300"
            }
          ],
          "contracts" => [
            {
              "id" => "1123"
            }
          ]
        }
      })
    end
  end
end
