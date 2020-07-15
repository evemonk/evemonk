# frozen_string_literal: true

require "rails_helper"

describe Types::EveCharacterType do
  describe "get characters" do
    let!(:eve_character1) do
      create(:eve_character,
        character_id: 123)
    end

    let!(:eve_character2) do
      create(:eve_character,
        character_id: 321)
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
            "id" => "123"
          },
          {
            "id" => "321"
          }
        ]
      })
    end
  end

  describe "get character by id" do
  end
end
