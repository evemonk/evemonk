# frozen_string_literal: true

class EveConstellationConstellationId < ActiveRecord::Migration[7.0]
  def up
    Eve::Constellation.find_each do |constellation|
      position = Eve::Position
        .where(positionable_type: "Eve::Constellation", positionable_id: constellation.id)
        .first

      constellation.update_column(:id, constellation.constellation_id)
      position&.update_column(:positionable_id, constellation.constellation_id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
