# frozen_string_literal: true

class AddIndexCharacterImplants < ActiveRecord::Migration[6.0]
  def change
    add_index :character_implants, :type_id
  end
end
