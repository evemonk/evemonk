# frozen_string_literal: true

class CreateCharacterMailLabels < ActiveRecord::Migration[6.0]
  def change
    create_table :character_mail_labels do |t|
      t.references :character, null: false, foreign_key: true
      t.string :color
      t.integer :label_id
      t.string :name
      t.integer :unread_count

      t.timestamps
    end
  end
end
