class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.integer :user_id
      t.integer :key_id
      t.string :v_code

      t.timestamps null: false
    end

    add_foreign_key :users, :api_keys
  end
end
