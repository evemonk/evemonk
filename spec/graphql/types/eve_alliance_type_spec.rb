# frozen_string_literal: true

require "rails_helper"

describe Types::EveAllianceType do
  describe "alliances" do
    let!(:eve_alliance1) do
      create(:eve_alliance,
        alliance_id: 123,
        name: "Alliance 1",
        ticker: "ALLIANCE1")
    end

    let!(:eve_alliance2) do
      create(:eve_alliance,
        alliance_id: 321,
        name: "Alliance 2",
        ticker: "ALLIANCE2")
    end

    let(:query) do
      %(
        {
          alliances {
            id
            name
            ticker
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
            "ticker" => "ALLIANCE1"
          },
          {
            "id" => "321",
            "name" => "Alliance 2",
            "ticker" => "ALLIANCE2"
          }
        ]
      })
    end
  end
end
