# frozen_string_literal: true

class AddUniqIndexEveAlliances < ActiveRecord::Migration[5.2]
  def change
    add_index :eve_alliances, :alliance_id, unique: true
  end
end
