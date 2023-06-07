# frozen_string_literal: true

class EveSystemSystemId < ActiveRecord::Migration[7.0]
  def up
    Eve::System.find_each do |system|
      system.update_column(:id, system.system_id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
