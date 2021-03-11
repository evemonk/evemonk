# frozen_string_literal: true

class CharacterCorporationHistoryInput < Upgrow::Input
  attribute :character_id
  attribute :corporation_id
  attribute :is_deleted
  attribute :record_id
  attribute :start_date

  validates :character_id, presence: true
  validates :corporation_id, presence: true
  validates :record_id, presence: true
  validates :start_date, presence: true
end
