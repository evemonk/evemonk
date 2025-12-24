# frozen_string_literal: true

class AddIndexEveCharsName < ActiveRecord::Migration[8.1]
  disable_ddl_transaction!

  def change
    add_index :eve_characters, :name, algorithm: :concurrently, name: :index_eve_characters_on_name_2
  end
end
