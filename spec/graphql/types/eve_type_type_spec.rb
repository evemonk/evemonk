# frozen_string_literal: true

require "rails_helper"

describe Types::EveRegionType do
  describe "get types" do
    let!(:eve_type_1) do
      create(:eve_type,
        id: 400)
    end

    let!(:eve_type_2) do
      create(:eve_type,
        id: 500)
    end

    let(:query) do
      %(
        {
          types(first: 2) {
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
        "types" => {
          "edges" => [
            {
              "node" => {
                "id" => "400"
              },
              "cursor" => "MQ"
            },
            {
              "node" => {
                "id" => "500"
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

  describe "get type by id" do
    let!(:eve_type) do
      create(:eve_type,
        id: 400)
    end

    let(:query) do
      %(
        {
          type(id: 400) {
            id
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "type" => {
          "id" => "400"
        }
      })
    end
  end
end
