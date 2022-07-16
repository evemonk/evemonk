# frozen_string_literal: true

require "rails_helper"

describe "get contracts" do
  let!(:eve_contract_1) do
    create(:eve_contract,
      contract_id: 123)
  end

  let!(:eve_contract_2) do
    create(:eve_contract,
      contract_id: 321)
  end

  let(:query) do
    %(
      {
        contracts(first: 2) {
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
      "contracts" => {
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
