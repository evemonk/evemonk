# frozen_string_literal: true

class AddLastCloneJumpDateToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :last_clone_jump_date, :datetime
    add_column :characters, :last_station_change_date, :datetime
  end
end
