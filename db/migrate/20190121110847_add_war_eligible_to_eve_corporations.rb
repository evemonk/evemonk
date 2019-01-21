# frozen_string_literal: true

class AddWarEligibleToEveCorporations < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_corporations, :war_eligible, :boolean
  end
end
