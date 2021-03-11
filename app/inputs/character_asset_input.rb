# frozen_string_literal: true

class CharacterAssetInput < Upgrow::Input
  attribute :character_id
  attribute :is_blueprint_copy
  attribute :is_singleton
  attribute :item_id
  attribute :location_flag
  attribute :location_id
  attribute :location_type
  attribute :quantity
  attribute :type_id

  validates :character_id, presence: true # TODO: add foreign key to db
  validates :is_singleton, presence: true
  validates :item_id, presence: true
  validates :location_flag, presence: true
  validates :location_id, presence: true
  validates :location_type, presence: true
  validates :quantity, presence: true
  validates :type_id, presence: true
end
