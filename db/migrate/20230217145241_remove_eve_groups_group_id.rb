# frozen_string_literal: true

class RemoveEveGroupsGroupId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_groups, :group_id, unique: true
    remove_column :eve_groups, :group_id, :bigint
  end
end
