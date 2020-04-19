# frozen_string_literal: true

class CharacterBlueprint < ApplicationRecord
  include Locationable

  belongs_to :character

  belongs_to :blueprint,
    class_name: "Eve::Blueprint",
    primary_key: "type_id",
    foreign_key: "type_id",
    optional: true
end
