# frozen_string_literal: true

class CreateNewEtags < ActiveRecord::Migration[6.0]
  def change
    create_table :etags do |t|
      t.text :url, null: false
      t.text :etag, null: false

      t.timestamps
    end
  end
end
