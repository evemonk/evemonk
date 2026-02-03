# frozen_string_literal: true

class CreateEveDeletedCharacters < ActiveRecord::Migration[8.1]
  def change
    create_table :eve_deleted_characters do |t|
      t.timestamps
    end
  end
end
