# frozen_string_literal: true

class CreateCharacterImplants < ActiveRecord::Migration[6.0]
  def change
    create_table :character_implants do |t|
      t.references :character
      t.bigint :type_id

      t.timestamps
    end
  end
end
