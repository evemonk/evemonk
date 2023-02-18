# frozen_string_literal: true

Rails.logger.info "Migrate Eve::Faction#faction_id to #id"

ActiveRecord::Base.transaction do
  Eve::Faction.find_each do |faction|
    faction.update_column(:id, faction.faction_id)
  end
end

Rails.logger.info "Done"
