# frozen_string_literal: true

class AddBodyToEveEtags < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_etags, :body, :text
  end
end
