# frozen_string_literal: true

class RemoveEtags < ActiveRecord::Migration[6.0]
  def change
    remove_column :eve_alliances, :etag, :string
    remove_column :eve_corporations, :etag, :string
  end
end
