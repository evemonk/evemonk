# frozen_string_literal: true

require "rails_helper"

describe Types::EveSystemType do
  describe "get systems" do
    let!(:eve_system1) do
      create(:eve_system,
        system_id: 123)
    end

    let!(:eve_system2) do
      create(:eve_system,
        system_id: 321)
    end

    let(:query) do
      %(
        {
          systems(first: 2) {
            edges {
              node {
                id
              }
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
              }
            },
            {
              "node" => {
                "id" => "321"
              }
            }
          ]
        }
      })
    end
  end

  describe "get system by id" do
    let!(:eve_system) do
      create(:eve_system,
        system_id: 123)
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
