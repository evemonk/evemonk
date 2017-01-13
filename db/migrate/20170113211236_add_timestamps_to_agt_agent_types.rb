class AddTimestampsToAgtAgentTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :agt_agent_types, :created_at, :datetime, null: false
    add_column :agt_agent_types, :updated_at, :datetime, null: false
  end
end
