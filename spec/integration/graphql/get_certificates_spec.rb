# frozen_string_literal: true

require "rails_helper"

describe "Get Certificates" do
  let!(:eve_group_1) do
    create(:eve_group,
      group_id: 255)
  end

  let!(:eve_group_2) do
    create(:eve_group,
      group_id: 1217)
  end

  let!(:eve_certificate_1) do
    create(:eve_certificate,
      id: 50,
      name: "Small Energy Turret",
      description: "Some description",
      group: eve_group_1)
  end

  let!(:eve_certificate_2) do
    create(:eve_certificate,
      id: 105,
      name: "Data and Relic Analyzers",
      description: "Some another description",
      group: eve_group_2)
  end

  let(:query) do
    %(
      query getCertificates {
        certificates(first: 2) {
          edges {
            node {
              id
              name
              description
              groupId
              group {
                id
              }
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
      "certificates" => {
        "edges" => [
          {
            "node" => {
              "id" => "50",
              "name" => "Small Energy Turret",
              "description" => "Some description",
              "groupId" => 255,
              "group" => {
                "id" => "255"
              }
            },
            "cursor" => "MQ"
          },
          {
            "node" => {
              "id" => "105",
              "name" => "Data and Relic Analyzers",
              "description" => "Some another description",
              "groupId" => 1217,
              "group" => {
                "id" => "1217"
              }
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
