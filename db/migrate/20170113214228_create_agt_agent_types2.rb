# frozen_string_literal: true
class CreateAgtAgentTypes2 < ActiveRecord::Migration[5.0]
  def change
    create_table :agt_agent_types do |t|
      t.string :agent_type
      t.integer :agent_type_id

      t.timestamps null: false
    end
  end
end
