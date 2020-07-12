# frozen_string_literal: true

require "rails_helper"

describe Types::EveCorporationType do
  describe "get corporations" do
    before { travel_to Time.zone.now }

    after { travel_back }

    let(:date_founded1) { Time.zone.now }

    let(:date_founded2) { Time.zone.now - 1.week }

    let!(:eve_alliance1) do
      create(:eve_alliance,
        alliance_id: 1_111)
    end

    let!(:eve_alliance2) do
      create(:eve_alliance,
        alliance_id: 1_222)
    end

    let!(:eve_alliance_corporation1) do
      create(:eve_alliance_corporation,
        alliance: eve_alliance1,
        corporation: eve_corporation1)
    end

    let!(:eve_alliance_corporation2) do
      create(:eve_alliance_corporation,
        alliance: eve_alliance2,
        corporation: eve_corporation1)
    end

    let!(:ceo1) do
      create(:eve_character,
        character_id: 10_111)
    end

    let!(:ceo2) do
      create(:eve_character,
        character_id: 10_222)
    end

    let!(:creator1) do
      create(:eve_character,
        character_id: 10_555)
    end

    let!(:creator2) do
      create(:eve_character,
        character_id: 10_666)
    end

    let!(:eve_faction1) do
      create(:eve_faction,
        faction_id: 1_000_111)
    end

    let!(:eve_faction2) do
      create(:eve_faction,
        faction_id: 1_000_222)
    end

    let!(:eve_station1) do
      create(:eve_station,
        station_id: 12_123_123)
    end

    let!(:eve_station2) do
      create(:eve_station,
        station_id: 12_321_321)
    end

    let!(:eve_corporation1) do
      create(:eve_corporation,
        corporation_id: 123,
        alliance: eve_alliance1,
        ceo: ceo1,
        creator: creator1,
        date_founded: date_founded1,
        description: "Corp description 1",
        faction: eve_faction1,
        home_station: eve_station1,
        member_count: 10,
        name: "Corp 1",
        shares: 101,
        tax_rate: 10.00,
        corporation_url: "https://url1.com/",
        war_eligible: true,
        npc: true)
    end

    let!(:eve_corporation2) do
      create(:eve_corporation,
        corporation_id: 321,
        alliance: eve_alliance2,
        ceo: ceo2,
        creator: creator2,
        date_founded: date_founded2,
        description: "Corp description 2",
        faction: eve_faction2,
        home_station: eve_station2,
        member_count: 100,
        name: "Corp 2",
        shares: 102,
        tax_rate: 20.00,
        corporation_url: "https://url2.com/",
        war_eligible: false,
        npc: false)
    end

    let!(:eve_character1) do
      create(:eve_character,
        character_id: 12_998,
        corporation: eve_corporation1)
    end

    let!(:eve_character2) do
      create(:eve_character,
        character_id: 12_999,
        corporation: eve_corporation2)
    end

    let(:query) do
      %(
        {
          corporations {
            id
            allianceId
            alliance {
              id
            }
            ceoId
            ceo {
              id
            }
            creatorId
            creator {
              id
            }
            dateFounded
            description
            factionId
            faction {
              id
            }
            homeStationId
            homeStation {
              id
            }
            memberCount
            name
            shares
            taxRate
            ticker
            url
            warEligible
            npc
            characters {
              id
            }
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "corporations" => [
          {
            "id" => "123",
            "allianceId" => 1_111,
            "alliance" => {
              "id" => "1111"
            },
            "ceoId" => 10_111,
            "ceo" => {
              "id" => "10111"
            },
            "creatorId" => 10_555,
            "creator" => {
              "id" => "10555"
            },
            "dateFounded" => date_founded1.iso8601,
            "description" => "Corp description 1",
            "factionId" => 1_000_111,
            "faction" => {
              "id" => "1000111"
            },
            "homeStationId" => 12_123_123,
            "homeStation" => {
              "id" => "12123123"
            },
            "memberCount" => 10,
            "name" => "Corp 1",
            "shares" => "101",
            "taxRate" => 10.0,
            "ticker" => "CORP 1",
            "url" => "https://url1.com/",
            "warEligible" => true,
            "npc" => true,
            "characters" => [
              {
                "id" => "12998"
              }
            ]
          },
          {
            "id" => "321",
            "allianceId" => 1_222,
            "alliance" => {
              "id" => "1222"
            },
            "ceoId" => 10_222,
            "ceo" => {
              "id" => "10222"
            },
            "creatorId" => 10_666,
            "creator" => {
              "id" => "10666"
            },
            "dateFounded" => date_founded2.iso8601,
            "description" => "Corp description 2",
            "factionId" => 1_000_222,
            "faction" => {
              "id" => "1000222"
            },
            "homeStationId" => 12_321_321,
            "homeStation" => {
              "id" => "12321321"
            },
            "memberCount" => 100,
            "name" => "Corp 2",
            "shares" => "102",
            "taxRate" => 20.0,
            "ticker" => "CORP 2",
            "url" => "https://url2.com/",
            "warEligible" => false,
            "npc" => false,
            "characters" => [
              {
                "id" => "12999"
              }
            ]
          }
        ]
      })
    end
  end
end
