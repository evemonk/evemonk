# frozen_string_literal: true

require "rails_helper"

describe Types::EveCharacterType do
  describe "get characters" do
    before { travel_to Time.zone.now }

    after { travel_back }

    let!(:birthday1) { Time.zone.now }

    let!(:birthday2) { Time.zone.now - 1.week }

    let!(:eve_alliance1) do
      create(:eve_alliance,
        alliance_id: 1_111)
    end

    let!(:eve_alliance2) do
      create(:eve_alliance,
        alliance_id: 1_222)
    end

    let!(:eve_corporation1) do
      create(:eve_corporation,
        corporation_id: 1_333,
        alliance: eve_alliance1)
    end

    let!(:eve_corporation2) do
      create(:eve_corporation,
        corporation_id: 1_444,
        alliance: eve_alliance2)
    end

    let!(:eve_ancestry1) do
      create(:eve_ancestry,
        ancestry_id: 128)
    end

    let!(:eve_ancestry2) do
      create(:eve_ancestry,
        ancestry_id: 256)
    end

    let!(:eve_bloodline1) do
      create(:eve_bloodline,
        bloodline_id: 512)
    end

    let!(:eve_bloodline2) do
      create(:eve_bloodline,
        bloodline_id: 1_024)
    end

    let!(:eve_faction1) do
      create(:eve_faction,
        faction_id: 2_048)
    end

    let!(:eve_faction2) do
      create(:eve_faction,
        faction_id: 4_096)
    end

    let!(:eve_race1) do
      create(:eve_race,
        race_id: 5_000)
    end

    let!(:eve_race2) do
      create(:eve_race,
        race_id: 6_000)
    end

    let!(:eve_character1) do
      create(:eve_character,
        character_id: 123,
        ancestry: eve_ancestry1,
        birthday: birthday1,
        bloodline: eve_bloodline1,
        alliance: eve_alliance1,
        corporation: eve_corporation1,
        description: "Description 1",
        faction: eve_faction1,
        gender: "male",
        name: "Name 1",
        race: eve_race1,
        security_status: 3.5,
        title: "Title 1")
    end

    let!(:eve_character2) do
      create(:eve_character,
        character_id: 321,
        ancestry: eve_ancestry2,
        birthday: birthday2,
        bloodline: eve_bloodline2,
        alliance: eve_alliance2,
        corporation: eve_corporation2,
        description: "Description 2",
        faction: eve_faction2,
        gender: "female",
        name: "Name 2",
        race: eve_race2,
        security_status: -10.0,
        title: "Title 2")
    end

    let(:query) do
      %(
        {
          characters {
            id
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
        "characters" => [
          {
            "id" => "123",
            "allianceId" => 1_111,
            "alliance" => {
              "id" => "1111"
            },
            "ancestryId" => 128,
            "ancestry" => {
              "id" => "128"
            },
            "birthday" => birthday1.iso8601,
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
          {
            "id" => "321",
            "allianceId" => 1_222,
            "alliance" => {
              "id" => "1222"
            },
            "ancestryId" => 256,
            "ancestry" => {
              "id" => "256"
            },
            "birthday" => birthday2.iso8601,
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
          }
        ]
      })
    end
  end

  describe "get character by id" do
    before { travel_to Time.zone.now }

    after { travel_back }

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
        description: "Description 1",
        faction: eve_faction,
        gender: "male",
        name: "Name 1",
        race: eve_race,
        security_status: 3.5,
        title: "Title 1")
    end

    let(:query) do
      %(
        {
          character(id: 123) {
            id
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
end
