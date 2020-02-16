# frozen_string_literal: true

class AddIndexCharacterKillmails < ActiveRecord::Migration[6.0]
  def change
    add_index :character_killmails, :killmail_hash, unique: true
    add_index :character_killmails, :killmail_id, unique: true
  end
end
