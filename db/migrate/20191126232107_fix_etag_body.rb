# frozen_string_literal: true

class FixEtagBody < ActiveRecord::Migration[6.0]
  def change
    remove_column :etags, :body, :text
    remove_column :eve_etags, :body, :text
    add_column :etags, :body, :json
    add_column :eve_etags, :body, :json
  end
end
