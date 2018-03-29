# frozen_string_literal: true

class AddUniqIndexEveBloodlines < ActiveRecord::Migration[5.2]
  def change
    add_index :eve_bloodlines, :bloodline_id, unique: true
  end
end
