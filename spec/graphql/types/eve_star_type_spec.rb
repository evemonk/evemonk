# frozen_string_literal: true

require "rails_helper"

describe Types::EveStarType do
  describe "get stars" do
    let!(:eve_star_1) do
      create(:eve_star,
        star_id: 123)
    end

    let!(:eve_star_2) do
      create(:eve_star,
        star_id: 321)
    end

    let(:query) do
      %(
        {
          stars(first: 2) {
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
        "stars" => {
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

  describe "get star by id" do
    let!(:eve_star) do
      create(:eve_star,
        star_id: 123)
    end

    let(:query) do
      %(
        {
          star(id: 123) {
            id
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "star" => {
          "id" => "123"
        }
      })
    end
  end
end
