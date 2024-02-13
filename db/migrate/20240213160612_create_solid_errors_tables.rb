# frozen_string_literal: true

class CreateSolidErrorsTables < ActiveRecord::Migration[7.0]
  def change
    create_table :solid_errors do |t|
      t.string :exception_class, null: false, limit: 200
      t.string :message, null: false
      t.string :severity, null: false, limit: 25
      t.string :source
      t.datetime :resolved_at, index: true

      t.timestamps

      t.index [:exception_class, :message, :severity, :source], unique: true, name: "solid_error_uniqueness_index"
    end

    create_table :solid_errors_occurrences do |t|
      t.belongs_to :error, null: false, foreign_key: {to_table: :solid_errors}
      t.text :backtrace
      t.json :context

      t.timestamps
    end
  end
end
