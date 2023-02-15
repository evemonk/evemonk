# frozen_string_literal: true

class RemoveEveBloodlinesBloodlineId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_bloodlines, :bloodline_id, unique: true
    remove_column :eve_bloodlines, :bloodline_id, :bigint
  end
end
