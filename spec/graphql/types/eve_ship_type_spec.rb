# frozen_string_literal: true

require "rails_helper"

describe Types::EveShipType do
  describe "get ships" do
    let!(:eve_ship_1) do
      create(:eve_type,
        id: 123)
    end

    let!(:eve_ship_2) do
      create(:eve_type,
        id: 321)
    end

    let(:query) do
      %(
        {
          ships(first: 2) {
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
        "ships" => {
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

  describe "get ship by id" do
    let!(:eve_ship) do
      create(:eve_type,
        id: 123)
    end

    let(:query) do
      %(
        {
          ship(id: 123) {
            id
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "ship" => {
          "id" => "123"
        }
      })
    end
  end
end
