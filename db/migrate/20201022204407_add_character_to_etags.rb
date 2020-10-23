# frozen_string_literal: true

class AddCharacterToEtags < ActiveRecord::Migration[6.0]
  def change
    add_column :etags, :character_id, :bigint
    add_foreign_key :etags, :characters
  end
end
