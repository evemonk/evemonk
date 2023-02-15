# frozen_string_literal: true

Rails.logger.info "Migrate Eve::Bloodline#bloodline_id to #id"

ActiveRecord::Base.transaction do
  start = 100

  Eve::Bloodline.find_each do |bloodline|
    bloodline.update_column(:id, start)
    start += 1
  end

  Eve::Bloodline.find_each do |bloodline|
    bloodline.update_column(:id, bloodline.bloodline_id)
  end
end
