# frozen_string_literal: true

class RemoveEveEtags < ActiveRecord::Migration[7.0]
  def change
    drop_table :eve_etags do |t|
      t.text :url, null: false
      t.text :etag, null: false
      t.timestamps
      t.json :body
      t.index :url, unique: true
    end
  end
end
