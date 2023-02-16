# frozen_string_literal: true

require "rails_helper"

describe "Get Agent by ID" do
  let!(:eve_corporation) do
    create(:eve_corporation,
      id: 222)
  end

  let!(:eve_agent) do
    create(:eve_agent,
      id: 123,
      name: "Agent 1",
      corporation: eve_corporation,
      level: 5)
  end

  let(:query) do
    %(
      query getAgentByID {
        agent(id: 123) {
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
          level
        }
      }
    )
  end

  let(:result) { EvemonkSchema.execute(query).as_json }

  specify do
    expect(result).to eq("data" => {
      "agent" => {
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
        "corporationId" => 222,
        "corporation" => {
          "id" => "222"
        },
        "level" => 5
      }
    })
  end
end
