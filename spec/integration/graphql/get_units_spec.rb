# frozen_string_literal: true

require "rails_helper"

describe "Get Units" do
  let!(:eve_unit_1) do
    create(:eve_unit,
      id: 1,
      description: nil,
      unit_name: "Length",
      display_name: nil)
  end

  let!(:eve_unit_2) do
    create(:eve_unit,
      id: 2,
      description: nil,
      unit_name: "Mass",
      display_name: nil)
  end

  let(:query) do
    %(
      query getUnits {
        units(first: 2) {
          edges {
            node {
              id
              description
              unitName
              displayName
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
      "units" => {
        "edges" => [
          {
            "node" => {
              "id" => "1",
              "description" => nil,
              "unitName" => "Length",
              "displayName" => nil
            },
            "cursor" => "MQ"
          },
          {
            "node" => {
              "id" => "2",
              "description" => nil,
              "unitName" => "Mass",
              "displayName" => nil
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
