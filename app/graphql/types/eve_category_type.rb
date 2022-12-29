# frozen_string_literal: true

module Types
  class EveCategoryType < Types::BaseObject
    description "Category object"

    field :id, ID,
      description: "Category ID",
      null: false

    field :name, EveNameType,
      description: "Name object",
      method: :itself,
      null: true

    field :published, Boolean,
      description: "Published",
      null: true

    field :groups, Types::EveGroupType.connection_type,
      description: "Groups collection",
      null: true
  end
end
