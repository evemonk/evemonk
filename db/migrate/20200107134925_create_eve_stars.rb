# frozen_string_literal: true

class CreateEveStars < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_stars do |t|
      t.bigint :age
      t.float :luminosity
      t.string :name
      t.bigint :radius
      t.bigint :solar_system_id
      t.string :spectral_class
      t.bigint :temperature
      t.bigint :type_id

      t.timestamps
    end
  end
end
