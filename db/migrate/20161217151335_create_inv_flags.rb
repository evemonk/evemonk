# frozen_string_literal: true
class CreateInvFlags < ActiveRecord::Migration[5.0]
  def change
    create_table :inv_flags do |t|
      t.integer :flag_id
      t.string :flag_name
      t.string :flag_text
      t.integer :order_id

      t.timestamps null: false
    end
  end
end
