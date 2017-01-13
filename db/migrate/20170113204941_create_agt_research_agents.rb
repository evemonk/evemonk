class CreateAgtResearchAgents < ActiveRecord::Migration[5.0]
  def change
    create_table :agt_research_agents do |t|
      t.integer :agent_id
      t.integer :type_id

      t.timestamps null: false
    end
  end
end
