# frozen_string_literal: true

class DropAgtAgentTypes < ActiveRecord::Migration[5.0]
  def change
    drop_table :agt_agent_types
  end
end
