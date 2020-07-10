# frozen_string_literal: true

require "rails_helper"

describe Types::EveAllianceType do
  describe "alliances" do
    let!(:eve_alliance1) do
      create(:eve_alliance,
        alliance_id: 123)
    end

    let!(:eve_alliance2) do
      create(:eve_alliance,
        alliance_id: 321)
    end

    let(:query) do
      %(
        {
          alliances {
            id
          }
        }
      )
    end

    let(:result) do
      EvemonkSchema.execute(query).as_json
    end

    specify do
      expect(result).to eq("data" => {
        "alliances" => [
          { "id" => "123" },
          { "id" => "321" },
        ]
      })
    end
  end
end
