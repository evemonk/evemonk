# frozen_string_literal: true

class DropVersions < ActiveRecord::Migration[7.0]
  def change
    drop_table :versions
  end
end
