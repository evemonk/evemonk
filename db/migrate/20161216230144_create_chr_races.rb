class CreateChrRaces < ActiveRecord::Migration[5.0]
  def change
    create_table :chr_races do |t|
      t.text :description
      t.integer :race_id
      t.string :race_name
      t.string :short_description
      t.integer :icon_id
    end
  end
end
