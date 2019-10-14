# frozen_string_literal: true

class CharacterImplant < ApplicationRecord
  belongs_to :character

  belongs_to :implant,
    class_name: "Eve::Type",
    primary_key: "type_id",
    foreign_key: "type_id",
    optional: true
end
