# frozen_string_literal: true

class AddIndexCharactersFactionId < ActiveRecord::Migration[5.2]
  def change
    add_index :characters, :faction_id
  end
end
