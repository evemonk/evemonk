# frozen_string_literal: true

class CharacterBlueprintInput < Upgrow::Input
  attribute :character_id
  attribute :item_id
  attribute :location_flag
  attribute :location_id
  attribute :material_efficiency
  attribute :quantity
  attribute :runs
  attribute :time_efficiency
  attribute :type_id

  validates :character_id, presence: true
  validates :item_id, presence: true
  validates :location_flag, presence: true
  validates :location_id, presence: true
  validates :material_efficiency, presence: true
  validates :quantity, presence: true
  validates :runs, presence: true
  validates :time_efficiency, presence: true
  validates :type_id, presence: true
end
