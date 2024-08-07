# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Get Characters" do
  before { freeze_time }

  let!(:birthday_1) { Time.zone.now }

  let!(:birthday_2) { 1.week.ago }

  let!(:eve_alliance_1) do
    create(:eve_alliance,
      id: 1_111)
  end

  let!(:eve_alliance_2) do
    create(:eve_alliance,
      id: 1_222)
  end

  let!(:eve_corporation_1) do
    create(:eve_corporation,
      id: 1_333,
      alliance: eve_alliance_1)
  end

  let!(:eve_corporation_2) do
    create(:eve_corporation,
      id: 1_444,
      alliance: eve_alliance_2)
  end

  let!(:eve_bloodline_1) do
    create(:eve_bloodline,
      id: 512)
  end

  let!(:eve_bloodline_2) do
    create(:eve_bloodline,
      id: 1_024)
  end

  let!(:eve_faction_1) do
    create(:eve_faction,
      id: 2_048)
  end

  let!(:eve_faction_2) do
    create(:eve_faction,
      id: 4_096)
  end

  let!(:eve_race_1) do
    create(:eve_race,
      id: 5_000)
  end

  let!(:eve_race_2) do
    create(:eve_race,
      id: 6_000)
  end

  let!(:eve_character_1) do
    create(:eve_character,
      id: 123,
      birthday: birthday_1,
      bloodline: eve_bloodline_1,
      alliance: eve_alliance_1,
      corporation: eve_corporation_1,
      description: "<b>Description 1</b>",
      faction: eve_faction_1,
      gender: "male",
      name: "Name 1",
      race: eve_race_1,
      security_status: 3.5,
      title: "Title 1")
  end

  let!(:eve_character_2) do
    create(:eve_character,
      id: 321,
      birthday: birthday_2,
      bloodline: eve_bloodline_2,
      alliance: eve_alliance_2,
      corporation: eve_corporation_2,
      description: "<b>Description 2</b>",
      faction: eve_faction_2,
      gender: "female",
      name: "Name 2",
      race: eve_race_2,
      security_status: -10.0,
      title: "Title 2")
  end

  let(:query) do
    %(
      query getCharacters {
        characters(first: 2) {
          edges {
            node {
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
      "characters" => {
        "edges" => [
          {
            "node" => {
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
              "birthday" => birthday_1.iso8601,
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
            },
            "cursor" => "MQ"
          },
          {
            "node" => {
              "id" => "321",
              "icon" => {
                "tiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/321/portrait?size=32",
                "small" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/321/portrait?size=64",
                "medium" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/321/portrait?size=128",
                "large" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/321/portrait?size=256",
                "huge" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/321/portrait?size=512",
                "gigantic" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/321/portrait?size=1024"
              },
              "allianceId" => 1_222,
              "alliance" => {
                "id" => "1222"
              },
              "birthday" => birthday_2.iso8601,
              "bloodlineId" => 1_024,
              "bloodline" => {
                "id" => "1024"
              },
              "corporationId" => 1_444,
              "corporation" => {
                "id" => "1444"
              },
              "description" => "Description 2",
              "factionId" => 4_096,
              "faction" => {
                "id" => "4096"
              },
              "gender" => "female",
              "name" => "Name 2",
              "raceId" => 6_000,
              "race" => {
                "id" => "6000"
              },
              "securityStatus" => -10.0,
              "title" => "Title 2"
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
