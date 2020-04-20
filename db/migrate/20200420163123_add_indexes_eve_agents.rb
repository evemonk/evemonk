# frozen_string_literal: true

class AddIndexesEveAgents < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_agents, :agent_type_id
    add_index :eve_agents, :division_id
    add_index :eve_agents, :location_id
  end
end
