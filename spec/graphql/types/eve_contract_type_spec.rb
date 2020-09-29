# frozen_string_literal: true

require "rails_helper"

describe Types::EveContractType do
  describe "get contracts" do
    let!(:eve_contract1) do
      create(:eve_contract,
        contract_id: 123)
    end

    let!(:eve_contract2) do
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

  describe "get contract by id" do
    let!(:eve_contract) do
      create(:eve_contract,
        contract_id: 123)
    end

    let(:query) do
      %(
        {
          contract(id: 123) {
            id
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "contract" => {
          "id" => "123"
        }
      })
    end
  end
end
