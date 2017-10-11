class AddWalletToCharacters < ActiveRecord::Migration[5.1]
  def change
    add_column :characters, :wallet, :float
  end
end
