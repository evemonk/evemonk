# frozen_string_literal: true

require "rails_helper"

describe "Get Agents" do
  let!(:eve_corporation) do
    create(:eve_corporation,
      corporation_id: 222)
  end

  let!(:eve_agent_1) do
    create(:eve_agent,
      id: 123,
      name: "Agent 1",
      corporation_id: nil)
  end

  let!(:eve_agent_2) do
    create(:eve_agent,
      id: 321,
      name: "Agent 2",
      corporation_id: 222)
  end

  let(:query) do
    %(
      query getAgents {
        agents(first: 2) {
          edges {
            node {
              id
              name
              icon {
                tiny
                small
                medium
                large
                huge
                gigantic
              }
              corporationId
              corporation {
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
      "agents" => {
        "edges" => [
          {
            "node" => {
              "id" => "123",
              "name" => "Agent 1",
              "icon" => {
                "tiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123/portrait?size=32",
                "small" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123/portrait?size=64",
                "medium" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123/portrait?size=128",
                "large" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123/portrait?size=256",
                "huge" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123/portrait?size=512",
                "gigantic" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/123/portrait?size=1024"
              },
              "corporationId" => nil,
              "corporation" => nil
            },
            "cursor" => "MQ"
          },
          {
            "node" => {
              "id" => "321",
              "name" => "Agent 2",
              "icon" => {
                "tiny" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/321/portrait?size=32",
                "small" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/321/portrait?size=64",
                "medium" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/321/portrait?size=128",
                "large" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/321/portrait?size=256",
                "huge" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/321/portrait?size=512",
                "gigantic" => "https://imageproxy.evemonk.com/https://images.evetech.net/characters/321/portrait?size=1024"
              },
              "corporationId" => 222,
              "corporation" => {
                "id" => "222"
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
