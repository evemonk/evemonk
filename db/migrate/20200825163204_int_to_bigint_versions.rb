# frozen_string_literal: true

class IntToBigintVersions < ActiveRecord::Migration[6.0]
  def change
    change_column :versions, :item_id, :bigint
  end
end
