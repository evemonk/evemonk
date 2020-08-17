# frozen_string_literal: true

module Types
  class EveIconType < Types::BaseObject
    field :id, ID, null: false
    field :description, String, null: true
    field :icon_file, String, null: true
    field :obsolete, Boolean, null: true

    def id
      object.icon_id
    end
  end
end
