# frozen_string_literal: true

class DropAgtAgents < ActiveRecord::Migration[5.0]
  def change
    drop_table :agt_agents
  end
end
