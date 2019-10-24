# frozen_string_literal: true

class CharacterSkill < ApplicationRecord
  belongs_to :character

  belongs_to :skill,
             class_name: "Eve::Type",
             primary_key: "type_id",
             foreign_key: "skill_id",
             optional: true
end
