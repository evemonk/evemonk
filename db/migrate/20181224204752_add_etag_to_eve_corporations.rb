# frozen_string_literal: true

class AddEtagToEveCorporations < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_corporations, :etag, :string
  end
end
