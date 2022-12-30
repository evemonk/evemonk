# frozen_string_literal: true

class CharacterSkill < ApplicationRecord
  belongs_to :character

  belongs_to :skill, class_name: "Eve::Type", optional: true
end
