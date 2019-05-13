# frozen_string_literal: true

class DropIndexEtagsUrl < ActiveRecord::Migration[6.0]
  def change
    remove_index :etags, :url
  end
end
