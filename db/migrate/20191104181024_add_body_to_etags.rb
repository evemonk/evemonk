# frozen_string_literal: true

class AddBodyToEtags < ActiveRecord::Migration[6.0]
  def change
    add_column :etags, :body, :text
  end
end
