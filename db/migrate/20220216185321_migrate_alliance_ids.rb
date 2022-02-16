# frozen_string_literal: true

class MigrateAllianceIds < ActiveRecord::Migration[7.0]
  class Eve
    class Alliance < ActiveRecord::Base
      self.table_name = "eve_alliances"
    end
  end

  def change
    ActiveRecord::Base.transaction do
      Eve::Alliance.find_each do |alliance|
        alliance.update!(id: alliance.alliance_id)
      end
    end
  end
end
