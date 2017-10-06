class AddPortraitToCharacters < ActiveRecord::Migration[5.1]
  def change
    add_column :characters, :portrait_small, :string
    add_column :characters, :portrait_medium, :string
    add_column :characters, :portrait_large, :string
    add_column :characters, :portrait_huge, :string
  end
end
