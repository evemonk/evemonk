# frozen_string_literal: true

class DropAgtResearchAgents < ActiveRecord::Migration[5.2]
  def change
    drop_table :agt_research_agents
  end
end
