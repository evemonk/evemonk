# frozen_string_literal: true

require "rails_helper"

describe Types::EveStationType do
  describe "get stations" do
    let!(:eve_station_1) do
      create(:eve_station,
        id: 123)
    end

    let!(:eve_station_2) do
      create(:eve_station,
        id: 321)
    end

    let(:query) do
      %(
        {
          stations(first: 2) {
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
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "stations" => {
          "edges" => [
            {
              "node" => {
                "id" => "123"
              },
              "cursor" => "MQ"
            },
            {
              "node" => {
                "id" => "321"
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

  describe "get station by id" do
    let!(:eve_station) do
      create(:eve_station,
        id: 123)
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
