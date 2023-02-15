# frozen_string_literal: true

Rails.logger.info "Migrate Eve::Race#race_id to #id"

Eve::Race.find_each do |race|
  race.update!(id: race.race_id)
end

Rails.logger.info "Done"
