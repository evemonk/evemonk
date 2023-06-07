# frozen_string_literal: true

class EveConstellationConstellationId < ActiveRecord::Migration[7.0]
  def up
    # Eve::Constellation.find_each do |constellation|
    #   constellation.update_column(:id, constellation.constellation_id)
    # end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
