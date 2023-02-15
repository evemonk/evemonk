# frozen_string_literal: true

Rails.logger.info "Migrate Eve::Race#race_id to #id"

ActiveRecord::Base.transaction do
  start = 100

  Eve::Race.find_each do |race|
    race.update_column(:id, start)
    start += 1
  end

  Eve::Race.find_each do |race|
    race.update_column(:id, race.race_id)
  end
end

Rails.logger.info "Done"
