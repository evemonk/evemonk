# frozen_string_literal: true

require "rails_helper"

describe Types::EveStationType do
  describe "get stations" do
    let!(:eve_station1) do
      create(:eve_station,
        station_id: 123)
    end

    let!(:eve_station2) do
      create(:eve_station,
        station_id: 321)
    end

    let(:query) do
      %(
        {
          stations {
            id
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "stations" => [
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

  describe "get station by id" do
    let!(:eve_station) do
      create(:eve_station,
        station_id: 123)
    end

    let(:query) do
      %(
        {
          station(id: 123) {
            id
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "station" => {
          "id" => "123"
        }
      })
    end
  end
end
