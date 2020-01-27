class CreateEveAgents < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_agents do |t|
      t.bigint :agent_id
      t.bigint :agent_type_id
      t.bigint :corporation_id
      t.bigint :division_id
      t.boolean :is_locator
      t.integer :level
      t.bigint :location_id
      t.integer :quality

      t.timestamps
    end

    add_index :eve_agents, :agent_id, unique: true
    add_index :eve_agents, :corporation_id
  end
end
