class CreateSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :skills do |t|
      t.references :character, null: false, foreign_key: true
      t.integer :active_skill_level
      t.integer :skill_id
      t.integer :skillpoints_in_skill
      t.integer :trained_skill_level

      t.timestamps
    end
  end
end
