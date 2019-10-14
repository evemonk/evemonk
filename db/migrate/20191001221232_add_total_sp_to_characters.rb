# frozen_string_literal: true

class AddTotalSpToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :total_sp, :bigint
  end
end
