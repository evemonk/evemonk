# frozen_string_literal: true

module Types
  class EveGroupType < Types::BaseObject
    description "Group object"

    field :id, ID,
      method: :group_id,
      description: "Group ID",
      null: false

    field :name, EveNameType,
      description: "Name object",
      method: :itself,
      null: true

    field :published, Boolean,
      description: "Published",
      null: true

    field :category_id, Integer,
      description: "Category ID",
      null: true

    field :category, Types::EveCategoryType,
      description: "Category",
      null: true

    field :types, Types::EveTypeType.connection_type,
      description: "Types collection",
      null: true
  end
end
