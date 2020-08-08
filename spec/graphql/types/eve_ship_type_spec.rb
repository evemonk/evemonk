# frozen_string_literal: true

require "rails_helper"

describe Types::EveShipType do
  describe "get ships" do
    let!(:eve_ship1) do
      create(:eve_type,
        type_id: 123)
    end

    let!(:eve_ship2) do
      create(:eve_type,
        type_id: 321)
    end

    let(:query) do
      %(
        {
          ships {
            id
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "ships" => [
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

  describe "get ship by id" do
    let!(:eve_ship) do
      create(:eve_type,
        type_id: 123)
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
