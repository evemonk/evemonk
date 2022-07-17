# frozen_string_literal: true

require "rails_helper"

describe Types::EveSystemType do
  describe "get systems" do
    let!(:eve_system_1) do
      create(:eve_system,
        id: 123)
    end

    let!(:eve_system_2) do
      create(:eve_system,
        id: 321)
    end

    let(:query) do
      %(
        {
          systems(first: 2) {
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
        "systems" => {
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

  describe "get system by id" do
    let!(:eve_system) do
      create(:eve_system,
        id: 123)
    end

    let(:query) do
      %(
        {
          system(id: 123) {
            id
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "system" => {
          "id" => "123"
        }
      })
    end
  end
end
