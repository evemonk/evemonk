# frozen_string_literal: true

require "rails_helper"

describe Types::EveAllianceType do
  describe "get alliances" do
    before { travel_to Time.zone.now }

    after { travel_back }

    let(:date_founded_1) { Time.zone.now }

    let(:date_founded_2) { Time.zone.now - 1.week }

    let!(:creator_corporation_1) do
      create(:eve_corporation,
        corporation_id: 222)
    end

    let!(:creator_corporation_2) do
      create(:eve_corporation,
        corporation_id: 333)
    end

    let!(:executor_corporation_1) do
      create(:eve_corporation,
        corporation_id: 444)
    end

    let!(:executor_corporation_2) do
      create(:eve_corporation,
        corporation_id: 555)
    end

    let!(:creator_1) do
      create(:eve_character,
        character_id: 4_444)
    end

    let!(:creator_2) do
      create(:eve_character,
        character_id: 5_555)
    end

    let!(:eve_faction_1) do
      create(:eve_faction,
        faction_id: 10_111)
    end

    let!(:eve_faction_2) do
      create(:eve_faction,
        faction_id: 10_222)
    end

    let!(:eve_alliance_1) do
      create(:eve_alliance,
        alliance_id: 123,
        name: "Alliance 1",
        ticker: "ALLIANCE1",
        date_founded: date_founded_1,
        creator_corporation: creator_corporation_1,
        creator: creator_1,
        executor_corporation: executor_corporation_1,
        faction: eve_faction_1)
    end

    let!(:eve_alliance_2) do
      create(:eve_alliance,
        alliance_id: 321,
        name: "Alliance 2",
        ticker: "ALLIANCE2",
        date_founded: date_founded_2,
        creator_corporation: creator_corporation_2,
        creator: creator_2,
        executor_corporation: executor_corporation_2,
        faction: eve_faction_2)
    end

    let!(:eve_corporation_1) do
      create(:eve_corporation,
        corporation_id: 100_111,
        alliance: eve_alliance_1,
        member_count: 1)
    end

    let!(:eve_corporation_2) do
      create(:eve_corporation,
        corporation_id: 100_222,
        alliance: eve_alliance_2,
        member_count: 1)
    end

    let!(:eve_character_1) do
      create(:eve_character,
        corporation: eve_corporation_1,
        character_id: 111_111)
    end

    let!(:eve_character_2) do
      create(:eve_character,
        corporation: eve_corporation_2,
        character_id: 111_222)
    end

    let(:query) do
      %(
        {
          alliances(first: 2) {
            edges {
              node {
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
                corporations(first: 1) {
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
                characters(first: 1) {
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
        "alliances" => {
          "edges" => [
            {
              "node" => {
                "id" => "123",
                "name" => "Alliance 1",
                "ticker" => "ALLIANCE1",
                "dateFounded" => date_founded_1.iso8601,
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
                "corporations" => {
                  "edges" => [
                    {
                      "node" => {
                        "id" => "100111"
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
                },
                "characters" => {
                  "edges" => [
                    {
                      "node" => {
                        "id" => "111111"
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
                "name" => "Alliance 2",
                "ticker" => "ALLIANCE2",
                "dateFounded" => date_founded_2.iso8601,
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
                "corporations" => {
                  "edges" => [
                    {
                      "node" => {
                        "id" => "100222"
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
                },
                "characters" => {
                  "edges" => [
                    {
                      "node" => {
                        "id" => "111222"
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
        alliance: eve_alliance,
        member_count: 1)
    end

    let!(:eve_character) do
      create(:eve_character,
        corporation: eve_corporation,
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
            corporations(first: 1) {
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
            characters(first: 1) {
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
          "corporations" => {
            "edges" => [
              {
                "node" => {
                  "id" => "100111"
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
          },
          "characters" => {
            "edges" => [
              {
                "node" => {
                  "id" => "111111"
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
