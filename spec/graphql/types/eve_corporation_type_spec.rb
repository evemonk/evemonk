# frozen_string_literal: true

require "rails_helper"

describe Types::EveCorporationType do
  describe "get corporations" do
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

    let!(:eve_corporation1) do
      create(:eve_corporation,
        corporation_id: 123,
        alliance_id: 1_111)
    end

    let!(:eve_corporation2) do
      create(:eve_corporation,
        corporation_id: 321,
        alliance_id: 1_222)
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
            }
          },
          {
            "id" => "321",
            "allianceId" => 1222,
            "alliance" => {
              "id" => "1222"
            }
          }
        ]
      })
    end
  end
end
