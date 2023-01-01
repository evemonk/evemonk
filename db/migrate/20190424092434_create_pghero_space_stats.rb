# frozen_string_literal: true

class CreatePgheroSpaceStats < ActiveRecord::Migration[6.0]
  def change
    # rubocop:disable Rails/CreateTableWithTimestamps
    create_table :pghero_space_stats do |t|
      t.text :database
      t.text :schema
      t.text :relation
      t.integer :size, limit: 8
      t.timestamp :captured_at
    end
    # rubocop:enable Rails/CreateTableWithTimestamps

    add_index :pghero_space_stats, [:database, :captured_at]
  end
end
