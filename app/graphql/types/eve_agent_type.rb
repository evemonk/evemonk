# frozen_string_literal: true

module Types
  class EveAgentType < Types::BaseObject
    description "Agent object"

    field :id, ID,
      description: "Agent ID",
      null: false

    field :name, String,
      description: "Agent name",
      null: true

    field :icon, EveAgentIconType,
      description: "Eve Agent Icons",
      method: :itself,
      null: true

    field :corporation_id, Integer,
      description: "Corporation ID",
      null: true

    field :corporation, Types::EveCorporationType,
      description: "Agent Corporation",
      null: true

    field :level, Integer,
      description: "Level",
      null: true

    # TODO: location -> Eve::Station

    # t.bigint "agent_type_id"
    # t.bigint "division_id"
    # t.boolean "is_locator"
    # t.integer "level"
    # t.bigint "location_id"
    # t.integer "quality"
  end
end
