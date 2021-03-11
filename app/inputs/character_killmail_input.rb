# frozen_string_literal: true

class CharacterKillmailInput < Upgrow::Input
  attribute :character_id
  attribute :killmail_hash
  attribute :killmail_id

  validates :character_id, presence: true
  validates :killmail_hash, presence: true
  validates :killmail_id, presence: true
end
