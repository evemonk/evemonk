# frozen_string_literal: true

module Types
  class EveCertificateType < Types::BaseObject
    description "Certificate object"

    field :id, ID,
      description: "Certificate ID",
      null: false

    field :name, String,
      description: "Certificate name",
      null: true

    field :description, String,
      description: "Certificate description",
      null: true

    field :group_id, Integer,
      description: "Group ID",
      null: true

    field :group, Types::EveGroupType,
      description: "Group",
      null: true
  end
end
