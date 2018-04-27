# frozen_string_literal: true

class AddIndexCharactersBloodlineId < ActiveRecord::Migration[5.2]
  def change
    add_index :characters, :bloodline_id
  end
end
