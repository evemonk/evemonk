# frozen_string_literal: true

require "rails_helper"

describe Types::EveAllianceType do
  describe "get alliances" do
    before { travel_to Time.zone.now }

    after { travel_back }

    let(:date_founded1) { Time.zone.now }

    let(:date_founded2) { Time.zone.now - 1.week }

    let!(:creator_corporation1) do
      create(:eve_corporation,
        corporation_id: 222)
    end

    let!(:creator_corporation2) do
      create(:eve_corporation,
        corporation_id: 333)
    end

    let!(:executor_corporation1) do
      create(:eve_corporation,
        corporation_id: 444)
    end

    let!(:executor_corporation2) do
      create(:eve_corporation,
        corporation_id: 555)
    end

    let!(:creator1) do
      create(:eve_character,
        character_id: 4_444)
    end

    let!(:creator2) do
      create(:eve_character,
        character_id: 5_555)
    end

    let!(:eve_faction1) do
      create(:eve_faction,
        faction_id: 10_111)
    end

    let!(:eve_faction2) do
      create(:eve_faction,
        faction_id: 10_222)
    end

    let!(:eve_alliance1) do
      create(:eve_alliance,
        alliance_id: 123,
        name: "Alliance 1",
        ticker: "ALLIANCE1",
        date_founded: date_founded1,
        creator_corporation: creator_corporation1,
        creator: creator1,
        executor_corporation: executor_corporation1,
        faction: eve_faction1)
    end

    let!(:eve_alliance2) do
      create(:eve_alliance,
        alliance_id: 321,
        name: "Alliance 2",
        ticker: "ALLIANCE2",
        date_founded: date_founded2,
        creator_corporation: creator_corporation2,
        creator: creator2,
        executor_corporation: executor_corporation2,
        faction: eve_faction2)
    end

    let!(:eve_corporation1) do
      create(:eve_corporation,
        corporation_id: 100_111,
        alliance: eve_alliance1,
        member_count: 1)
    end

    let!(:eve_corporation2) do
      create(:eve_corporation,
        corporation_id: 100_222,
        alliance: eve_alliance2,
        member_count: 1)
    end

    let!(:eve_alliance_corporation1) do
      create(:eve_alliance_corporation,
        corporation: eve_corporation1,
        alliance: eve_alliance1)
    end

    let!(:eve_alliance_corporation2) do
      create(:eve_alliance_corporation,
        corporation: eve_corporation2,
        alliance: eve_alliance2)
    end

    let!(:eve_character1) do
      create(:eve_character,
        corporation: eve_corporation1,
        character_id: 111_111)
    end

    let!(:eve_character2) do
      create(:eve_character,
        corporation: eve_corporation2,
        character_id: 111_222)
    end

    let(:query) do
      %(
        {
          alliances {
            id
            name
            ticker
            dateFounded
            creatorCorporationId
            creatorCorporation {
              id
            }
            creatorId
            creator {
              id
            }
            executorCorporationId
            executorCorporation {
              id
            }
            factionId
            faction {
              id
            }
            corporationsCount
            charactersCount
            corporations {
              id
            }
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
        "alliances" => [
          {
            "id" => "123",
            "name" => "Alliance 1",
            "ticker" => "ALLIANCE1",
            "dateFounded" => date_founded1.iso8601,
            "creatorCorporationId" => 222,
            "creatorCorporation" => {
              "id" => "222"
            },
            "creatorId" => 4444,
            "creator" => {
              "id" => "4444"
            },
            "executorCorporationId" => 444,
            "executorCorporation" => {
              "id" => "444"
            },
            "factionId" => 10_111,
            "faction" => {
              "id" => "10111"
            },
            "corporationsCount" => 1,
            "charactersCount" => 1,
            "corporations" => [
              {
                "id" => "100111"
              }
            ],
            "characters" => [
              {
                "id" => "111111"
              }
            ]
          },
          {
            "id" => "321",
            "name" => "Alliance 2",
            "ticker" => "ALLIANCE2",
            "dateFounded" => date_founded2.iso8601,
            "creatorCorporationId" => 333,
            "creatorCorporation" => {
              "id" => "333"
            },
            "creatorId" => 5555,
            "creator" => {
              "id" => "5555"
            },
            "executorCorporationId" => 555,
            "executorCorporation" => {
              "id" => "555"
            },
            "factionId" => 10_222,
            "faction" => {
              "id" => "10222"
            },
            "corporationsCount" => 1,
            "charactersCount" => 1,
            "corporations" => [
              {
                "id" => "100222"
              }
            ],
            "characters" => [
              {
                "id" => "111222"
              }
            ]
          }
        ]
      })
    end
  end

  describe "get alliance by id" do
    before { travel_to Time.zone.now }

    after { travel_back }

    let(:date_founded) { Time.zone.now }

    let!(:creator_corporation) do
      create(:eve_corporation,
        corporation_id: 222)
    end

    let!(:executor_corporation) do
      create(:eve_corporation,
        corporation_id: 444)
    end

    let!(:creator) do
      create(:eve_character,
        character_id: 4_444)
    end

    let!(:eve_faction) do
      create(:eve_faction,
        faction_id: 10_111)
    end

    let!(:eve_alliance) do
      create(:eve_alliance,
        alliance_id: 123,
        name: "Alliance 1",
        ticker: "ALLIANCE1",
        date_founded: date_founded,
        creator_corporation: creator_corporation,
        creator: creator,
        executor_corporation: executor_corporation,
        faction: eve_faction)
    end

    let!(:eve_corporation) do
      create(:eve_corporation,
        corporation_id: 100_111,
        alliance_id: 123,
        member_count: 1)
    end

    let!(:eve_alliance_corporation) do
      create(:eve_alliance_corporation,
        corporation_id: 100_111,
        alliance_id: 123)
    end

    let!(:eve_character) do
      create(:eve_character,
        corporation_id: 100_111,
        character_id: 111_111)
    end

    let(:query) do
      %(
        {
          alliance(id: 123) {
            id
            name
            ticker
            dateFounded
            creatorCorporationId
            creatorCorporation {
              id
            }
            creatorId
            creator {
              id
            }
            executorCorporationId
            executorCorporation {
              id
            }
            factionId
            faction {
              id
            }
            corporationsCount
            charactersCount
            corporations {
              id
            }
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
        "alliance" => {
          "id" => "123",
          "name" => "Alliance 1",
          "ticker" => "ALLIANCE1",
          "dateFounded" => date_founded.iso8601,
          "creatorCorporationId" => 222,
          "creatorCorporation" => {
            "id" => "222"
          },
          "creatorId" => 4444,
          "creator" => {
            "id" => "4444"
          },
          "executorCorporationId" => 444,
          "executorCorporation" => {
            "id" => "444"
          },
          "factionId" => 10_111,
          "faction" => {
            "id" => "10111"
          },
          "corporationsCount" => 1,
          "charactersCount" => 1,
          "corporations" => [
            {
              "id" => "100111"
            }
          ],
          "characters" => [
            {
              "id" => "111111"
            }
          ]
        }
      })
    end
  end
end
