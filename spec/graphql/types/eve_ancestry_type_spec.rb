# frozen_string_literal: true

require "rails_helper"

describe Types::EveAncestryType do
  describe "get ancestries" do
    let!(:eve_ancestry1) do
      create(:eve_ancestry,
        ancestry_id: 123)
    end

    let!(:eve_ancestry2) do
      create(:eve_ancestry,
        ancestry_id: 321)
    end

    let(:query) do
      %(
        {
          ancestries {
            id
            name
            description
            bloodlineId
            bloodline {
              id
            }
            iconId
            icon {
              id
            }
            shortDescription
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
          "ancestries" => [
            {
              "id" => "123",
            },
            {
              "id" => "321",
            }
          ]
      })
    end

  end
end
