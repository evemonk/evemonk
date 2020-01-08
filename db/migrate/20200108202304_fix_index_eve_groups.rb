# frozen_string_literal: true

class FixIndexEveGroups < ActiveRecord::Migration[6.0]
  def change
    remove_index :eve_groups, :group_id
    add_index :eve_groups, :group_id, unique: true
  end
end
