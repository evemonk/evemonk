# frozen_string_literal: true

require "rails_helper"

describe Types::EveBlueprintType do
  describe "get blueprints" do
    let!(:eve_blueprint1) do
      create(:eve_type,
        type_id: 4_001,
        is_blueprint: true)
    end

    let!(:eve_blueprint2) do
      create(:eve_type,
        type_id: 5_001,
        is_blueprint: true)
    end

    let(:query) do
      %(
        {
          blueprints(first: 2) {
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
        "blueprints" => {
          "edges" => [
            {
              "node" => {
                "id" => "4001"
              }
            },
            {
              "node" => {
                "id" => "5001"
              }
            }
          ]
        }
      })
    end
  end

  describe "get blueprint by id" do
    let!(:eve_blueprint) do
      create(:eve_type,
        type_id: 4_002,
        is_blueprint: true)
    end

    let(:query) do
      %(
        {
          blueprint(id: 4002) {
            id
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "blueprint" => {
          "id" => "4002"
        }
      })
    end
  end
end
