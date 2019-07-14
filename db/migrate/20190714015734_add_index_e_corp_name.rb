# frozen_string_literal: true

class AddIndexECorpName < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_corporations, :name
  end
end
