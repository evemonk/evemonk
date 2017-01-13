class AddTimestampsToAgtAgents < ActiveRecord::Migration[5.0]
  def change
    add_column :agt_agents, :created_at, :datetime, null: false
    add_column :agt_agents, :updated_at, :datetime, null: false
  end
end
