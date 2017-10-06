class AddMoreFieldsToCharacters < ActiveRecord::Migration[5.1]
  def change
    add_column :characters, :corporation_id, :integer
    add_column :characters, :birthday, :datetime
    add_column :characters, :gender, :string
    add_column :characters, :race_id, :integer
    add_column :characters, :bloodline_id, :integer
    add_column :characters, :description, :text
    add_column :characters, :alliance_id, :integer
    add_column :characters, :ancestry_id, :integer
    add_column :characters, :security_status, :decimal, precision: 18, scale: 16
  end
end
