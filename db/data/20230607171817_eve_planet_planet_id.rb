# frozen_string_literal: true

class EvePlanetPlanetId < ActiveRecord::Migration[7.0]
  def up
    Eve::Planet.find_each do |planet|
      planet.update_column(:id, planet.planet_id)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
