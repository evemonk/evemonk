# frozen_string_literal: true

class AddUniqIndexOnEtagsUrl < ActiveRecord::Migration[6.0]
  def change
    add_index :etags, :url
  end
end
