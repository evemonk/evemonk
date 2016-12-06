class AddForeignKeySecureTokensUsers < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :secure_tokens, :users
  end
end
