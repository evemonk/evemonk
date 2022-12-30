# frozen_string_literal: true

module Types
  class EveGraphicType < Types::BaseObject
    description "Graphic object"

    field :id, ID,
      description: "Graphic ID",
      null: false

    # field :collision_file, String,
    #   null: true
    #
    # field :graphic_file, String,
    #   null: true
    #
    # field :icon_folder, String,
    #   null: true
    #
    # field :sof_dna, String,
    #   null: true
    #
    # field :sof_fation_name, String,
    #   null: true
    #
    # field :sof_hull_name, String,
    #   null: true
    #
    # field :sof_race_name, String,
    #   null: true
  end
end
