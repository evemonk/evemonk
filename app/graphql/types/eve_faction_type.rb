# frozen_string_literal: true

module Types
  class EveFactionType < Types::BaseObject
    field :id, ID, null: false

    def id
      object.faction_id
    end
  end
end
