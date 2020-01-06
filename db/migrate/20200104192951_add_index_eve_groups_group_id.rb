# frozen_string_literal: true

class AddIndexEveGroupsGroupId < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_groups, :group_id
  end
end
