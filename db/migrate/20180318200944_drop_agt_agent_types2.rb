# frozen_string_literal: true

class DropAgtAgentTypes2 < ActiveRecord::Migration[5.2]
  def change
    drop_table :agt_agent_types
  end
end
