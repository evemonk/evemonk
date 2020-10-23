# frozen_string_literal: true

class UpdateEtagsUrlIndex < ActiveRecord::Migration[6.0]
  def change
    remove_index :etags, column: :url, unique: true
    add_index :etags, :url
  end
end
