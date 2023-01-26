# frozen_string_literal: true

class DropEtags < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :etags, :characters

    drop_table :etags do |t|
      t.text :url, null: false
      t.text :etag, null: false
      t.timestamps
      t.json :body
      t.bigint :character_id
      t.index :url
    end
  end
end
