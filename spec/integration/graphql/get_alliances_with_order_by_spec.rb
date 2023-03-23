# frozen_string_literal: true

require "rails_helper"

describe "Get Alliances with orderBy" do
  let!(:eve_alliance_1) { create(:eve_alliance, id: 1, characters_count: 0, corporations_count: 100) }

  let!(:eve_alliance_2) { create(:eve_alliance, id: 2, characters_count: 0, corporations_count: 200) }

  let!(:eve_alliance_3) { create(:eve_alliance, id: 3, characters_count: 300, corporations_count: 0) }

  let!(:eve_alliance_4) { create(:eve_alliance, id: 4, characters_count: 400, corporations_count: 0) }

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
  end

  context "when orderBy is CORPORATIONS_COUNT_ASC" do
    let(:order_by) { "CORPORATIONS_COUNT_ASC" }
  end

  context "when orderBy is CHARACTERS_COUNT_DESC" do
    let(:order_by) { "CHARACTERS_COUNT_DESC" }
  end

  context "when orderBy is CHARACTERS_COUNT_ASC" do
    let(:order_by) { "CHARACTERS_COUNT_ASC" }
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
                "corporationsCount" => 100,
                "charactersCount" => 0
              }
            },
            {
              "node" => {
                "id" => "2",
                "corporationsCount" => 200,
                "charactersCount" => 0
              }
            },
            {
              "node" => {
                "id" => "3",
                "corporationsCount" => 0,
                "charactersCount" => 300
              }
            },
            {
              "node" => {
                "id" => "4",
                "corporationsCount" => 0,
                "charactersCount" => 400
              }
            }
          ]
        }
      })
    end
  end
end
