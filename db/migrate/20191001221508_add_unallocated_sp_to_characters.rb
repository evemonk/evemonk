# frozen_string_literal: true

class AddUnallocatedSpToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :unallocated_sp, :bigint
  end
end
