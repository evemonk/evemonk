# frozen_string_literal: true

class AddNameToEveAgents < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_agents, :name, :string
  end
end
