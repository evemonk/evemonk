# frozen_string_literal: true

class AddEtagToAlliances < ActiveRecord::Migration[5.2]
  def change
    add_column :eve_alliances, :etag, :string
  end
end
