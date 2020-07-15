# frozen_string_literal: true

require "rails_helper"

describe Types::EveCharacterType do
  describe "get characters" do
    let!(:eve_alliance1) do
      create(:eve_alliance,
        alliance_id: 1_111)
    end

    let!(:eve_alliance2) do
      create(:eve_alliance,
        alliance_id: 1_222)
    end

    let!(:eve_character1) do
      create(:eve_character,
        character_id: 123,
        alliance: eve_alliance1)
    end

    let!(:eve_character2) do
      create(:eve_character,
        character_id: 321,
        alliance: eve_alliance2)
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
            }
          },
          {
            "id" => "321",
            "allianceId" => 1_222,
            "alliance" => {
              "id" => "1222"
            }
          }
        ]
      })
    end
  end

  describe "get character by id" do
  end
end
