# frozen_string_literal: true

require "rails_helper"

describe "Get Alliances with orderBy" do
  let!(:eve_alliance_1) { create(:eve_alliance, id: 1, characters_count: 100, corporations_count: 1_000) }

  let!(:eve_alliance_2) { create(:eve_alliance, id: 2, characters_count: 200, corporations_count: 2_000) }

  let!(:eve_alliance_3) { create(:eve_alliance, id: 3, characters_count: 300, corporations_count: 3_000) }

  let!(:eve_alliance_4) { create(:eve_alliance, id: 4, characters_count: 400, corporations_count: 4_000) }

  let(:query) do
    %(
      query getAlliances {
        alliances(first: 4, orderBy: #{order_by}) {
          edges {
            node {
              id
              corporationsCount
              charactersCount
            }
          }
        }
      }
    )
  end

  let(:result) { EvemonkSchema.execute(query).as_json }

  context "when orderBy is CORPORATIONS_COUNT_DESC" do
    let(:order_by) { "CORPORATIONS_COUNT_DESC" }

    specify do
      expect(result).to eq("data" => {
        "alliances" => {
          "edges" => [
            {
              "node" => {
                "id" => "4",
                "corporationsCount" => 4000,
                "charactersCount" => 400
              }
            },
            {
              "node" => {
                "id" => "3",
                "corporationsCount" => 3000,
                "charactersCount" => 300
              }
            },
            {
              "node" => {
                "id" => "2",
                "corporationsCount" => 2000,
                "charactersCount" => 200
              }
            },
            {
              "node" => {
                "id" => "1",
                "corporationsCount" => 1000,
                "charactersCount" => 100
              }
            }
          ]
        }
      })
    end
  end

  context "when orderBy is CORPORATIONS_COUNT_ASC" do
    let(:order_by) { "CORPORATIONS_COUNT_ASC" }

    specify do
      expect(result).to eq("data" => {
        "alliances" => {
          "edges" => [
            {
              "node" => {
                "id" => "1",
                "corporationsCount" => 1000,
                "charactersCount" => 100
              }
            },
            {
              "node" => {
                "id" => "2",
                "corporationsCount" => 2000,
                "charactersCount" => 200
              }
            },
            {
              "node" => {
                "id" => "3",
                "corporationsCount" => 3000,
                "charactersCount" => 300
              }
            },
            {
              "node" => {
                "id" => "4",
                "corporationsCount" => 4000,
                "charactersCount" => 400
              }
            }
          ]
        }
      })
    end
  end

  context "when orderBy is CHARACTERS_COUNT_DESC" do
    let(:order_by) { "CHARACTERS_COUNT_DESC" }

    specify do
      expect(result).to eq("data" => {
        "alliances" => {
          "edges" => [
            {
              "node" => {
                "id" => "4",
                "corporationsCount" => 4000,
                "charactersCount" => 400
              }
            },
            {
              "node" => {
                "id" => "3",
                "corporationsCount" => 3000,
                "charactersCount" => 300
              }
            },
            {
              "node" => {
                "id" => "2",
                "corporationsCount" => 2000,
                "charactersCount" => 200
              }
            },
            {
              "node" => {
                "id" => "1",
                "corporationsCount" => 1000,
                "charactersCount" => 100
              }
            }
          ]
        }
      })
    end
  end

  context "when orderBy is CHARACTERS_COUNT_ASC" do
    let(:order_by) { "CHARACTERS_COUNT_ASC" }

    specify do
      expect(result).to eq("data" => {
        "alliances" => {
          "edges" => [
            {
              "node" => {
                "id" => "1",
                "corporationsCount" => 1000,
                "charactersCount" => 100
              }
            },
            {
              "node" => {
                "id" => "2",
                "corporationsCount" => 2000,
                "charactersCount" => 200
              }
            },
            {
              "node" => {
                "id" => "3",
                "corporationsCount" => 3000,
                "charactersCount" => 300
              }
            },
            {
              "node" => {
                "id" => "4",
                "corporationsCount" => 4000,
                "charactersCount" => 400
              }
            }
          ]
        }
      })
    end
  end

  context "when orderBy is NONE" do
    let(:order_by) { "NONE" }

    specify do
      expect(result).to eq("data" => {
        "alliances" => {
          "edges" => [
            {
              "node" => {
                "id" => "1",
                "corporationsCount" => 1000,
                "charactersCount" => 100
              }
            },
            {
              "node" => {
                "id" => "2",
                "corporationsCount" => 2000,
                "charactersCount" => 200
              }
            },
            {
              "node" => {
                "id" => "3",
                "corporationsCount" => 3000,
                "charactersCount" => 300
              }
            },
            {
              "node" => {
                "id" => "4",
                "corporationsCount" => 4000,
                "charactersCount" => 400
              }
            }
          ]
        }
      })
    end
  end
end
