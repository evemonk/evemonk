# frozen_string_literal: true

class AddUniqIndexEveAncestries < ActiveRecord::Migration[5.2]
  def change
    add_index :eve_ancestries, :ancestry_id, unique: true
  end
end
