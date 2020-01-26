class CreateEveAgents < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_agents do |t|

      t.timestamps
    end
  end
end
