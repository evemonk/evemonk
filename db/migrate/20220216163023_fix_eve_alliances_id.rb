# frozen_string_literal: true

class FixEveAlliancesId < ActiveRecord::Migration[7.0]
  def change
    execute "ALTER TABLE eve_alliances ADD PRIMARY KEY (id);"
  end
end
