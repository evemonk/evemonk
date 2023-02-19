# frozen_string_literal: true

Rails.logger.info "Migrate Eve::Icon#icon_id to #id"

ActiveRecord::Base.transaction do
  start = 1_000_000

  Eve::Icon.find_each do |icon|
    icon.update_column(:id, start)
    start += 1
  end

  Eve::Icon.find_each do |icon|
    icon.update_column(:id, icon.icon_id)
  end
end

Rails.logger.info "Done"
