# frozen_string_literal: true

require "rails_helper"

describe "Get Character by ID" do
  before { travel_to Time.zone.now }

  let!(:birthday) { Time.zone.now }

  let!(:eve_alliance) do
    create(:eve_alliance,
      alliance_id: 1_111)
  end

  let!(:eve_corporation) do
    create(:eve_corporation,
      corporation_id: 1_333,
      alliance: eve_alliance)
  end

  let!(:eve_ancestry) do
    create(:eve_ancestry,
      ancestry_id: 128)
  end

  let!(:eve_bloodline) do
    create(:eve_bloodline,
      bloodline_id: 512)
  end

  let!(:eve_faction) do
    create(:eve_faction,
      faction_id: 2_048)
  end

  let!(:eve_race) do
    create(:eve_race,
      race_id: 5_000)
  end

  let!(:eve_character) do
    create(:eve_character,
      character_id: 123,
      ancestry: eve_ancestry,
      birthday: birthday,
      bloodline: eve_bloodline,
      alliance: eve_alliance,
      corporation: eve_corporation,
      description: "<b>Description 1</b>",
      faction: eve_faction,
      gender: "male",
      name: "Name 1",
      race: eve_race,
      security_status: 3.5,
      title: "Title 1")
  end

  let(:query) do
    %(
      query getCharacterByID {
        character(id: 123) {
          id
          icon {
            tiny
            small
            medium
            large
            huge
            gigantic
          }
          allianceId
          alliance {
            id
          }
          ancestryId
          ancestry {
            id
          }
          birthday
          bloodlineId
          bloodline {
            id
          }
          corporationId
          corporation {
            id
          }
          description
          factionId
          faction {
            id
          }
          gender
          name
          raceId
          race {
            id
          }
          securityStatus
          title
        }
      }
    )
  end

  let(:result) { EvemonkSchema.execute(query).as_json }

  specify do
    expect(result).to eq("data" => {
      "character" => {
        "id" => "123",
        "icon" => {
          "tiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123/portrait?size=32",
          "small" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123/portrait?size=64",
          "medium" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123/portrait?size=128",
          "large" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123/portrait?size=256",
          "huge" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123/portrait?size=512",
          "gigantic" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123/portrait?size=1024"
        },
        "allianceId" => 1_111,
        "alliance" => {
          "id" => "1111"
        },
        "ancestryId" => 128,
        "ancestry" => {
          "id" => "128"
        },
        "birthday" => birthday.iso8601,
        "bloodlineId" => 512,
        "bloodline" => {
          "id" => "512"
        },
        "corporationId" => 1_333,
        "corporation" => {
          "id" => "1333"
        },
        "description" => "Description 1",
        "factionId" => 2_048,
        "faction" => {
          "id" => "2048"
        },
        "gender" => "male",
        "name" => "Name 1",
        "raceId" => 5_000,
        "race" => {
          "id" => "5000"
        },
        "securityStatus" => 3.5,
        "title" => "Title 1"
      }
    })
  end
end
