# frozen_string_literal: true

class RemoveSolidErrors < ActiveRecord::Migration[7.1]
  def change
    drop_table :solid_errors_occurrences

    drop_table :solid_errors
  end
end
