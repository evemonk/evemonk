class AddIconsToEveAlliances < ActiveRecord::Migration[5.2]
  def change
    add_column :eve_alliances, :icon_small, :string
    add_column :eve_alliances, :icon_medium, :string
  end
end
