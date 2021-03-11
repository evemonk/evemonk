# frozen_string_literal: true

class CharacterImplantInput < Upgrow::Input
  attribute :character_id
  attribute :type_id

  validates :character_id, presence: true
  validates :type_id, presence: true
end
