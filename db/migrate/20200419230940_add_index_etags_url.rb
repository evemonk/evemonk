# frozen_string_literal: true

class AddIndexEtagsUrl < ActiveRecord::Migration[6.0]
  def change
    add_index :etags, :url, unique: true
  end
end
