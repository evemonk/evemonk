# frozen_string_literal: true

require "rails_helper"

describe Types::EveContractType do
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
