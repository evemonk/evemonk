# frozen_string_literal: true

class RemoveEveAgentsAgentId < ActiveRecord::Migration[7.0]
  def change
    remove_index :eve_agents, :agent_id, unique: true
    remove_column :eve_agents, :agent_id, :bigint
  end
end
