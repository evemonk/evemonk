# frozen_string_literal: true

class DropAgtAgents2 < ActiveRecord::Migration[5.2]
  def change
    drop_table :agt_agents
  end
end
