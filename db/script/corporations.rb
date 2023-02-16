# frozen_string_literal: true

Rails.logger.info "Migrate Eve::Race#race_id to #id"

ActiveRecord::Base.transaction do
  start = 2_100_000_000

  Eve::Corporation.find_each do |corporation|
    corporation.update_column(:id, start)
    start += 1
  end

  Eve::Corporation.find_each do |corporation|
    corporation.update_column(:id, corporation.corporation_id)
  end
end

Rails.logger.info "Done"
