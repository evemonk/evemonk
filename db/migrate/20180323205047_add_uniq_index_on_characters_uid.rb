# frozen_string_literal: true

class AddUniqIndexOnCharactersUid < ActiveRecord::Migration[5.2]
  def change
    add_index :characters, :uid, unique: true
  end
end
