# frozen_string_literal: true

class RemoveCharactersUid < ActiveRecord::Migration[6.0]
  def change
    remove_index :characters, column: :uid, unique: true
    remove_column :characters, :uid, :integer
  end
end
