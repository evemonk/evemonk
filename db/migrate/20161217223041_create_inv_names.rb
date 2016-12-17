class CreateInvNames < ActiveRecord::Migration[5.0]
  def change
    create_table :inv_names do |t|
      t.integer :item_id
      t.string :item_name

      t.timestamps null: false
    end
  end
end
