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
        alliance_id: 1_111,
        corporation_id: 123)
    end

    let!(:eve_alliance_corporation2) do
      create(:eve_alliance_corporation,
        alliance_id: 1_222,
        corporation_id: 321)
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

    let!(:eve_corporation1) do
      create(:eve_corporation,
        corporation_id: 123,
        alliance_id: 1_111,
        ceo_id: 10_111,
        creator_id: 10_555,
        date_founded: date_founded1,
        description: 'Corp description 1')
    end

    let!(:eve_corporation2) do
      create(:eve_corporation,
        corporation_id: 321,
        alliance_id: 1_222,
        ceo_id: 10_222,
        creator_id: 10_666,
        date_founded: date_founded2,
        description: 'Corp description 2')
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
          }
        }
      )
    end

    # field :faction_id, Integer, null: true
    # field :faction, Types::EveFactionType, null: true
    # field :home_station_id, Integer, null: true
    # field :home_station, Types::EveStationType, null: true
    # field :member_count, Integer, null: true
    # field :name, String, null: true
    # field :shares, GraphQL::Types::BigInt, null: true
    # field :tax_rate, Float, null: true
    # field :ticker, String, null: true
    # field :url, String, null: true
    # field :war_eligible, Boolean, null: true
    # field :npc, Boolean, null: true
    # field :characters, [Types::EveCharacterType], null: true

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
            "description" => "Corp description 1"
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
            "description" => "Corp description 2"
          }
        ]
      })
    end
  end
end
