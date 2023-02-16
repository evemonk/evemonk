# frozen_string_literal: true

Rails.logger.info "Migrate Eve::Category#category_id to #id"

ActiveRecord::Base.transaction do
  start = 1_000_000

  Eve::Category.find_each do |category|
    category.update_column(:id, start)
    start += 1
  end

  Eve::Category.find_each do |category|
    category.update_column(:id, category.category_id)
  end
end

Rails.logger.info "Done"
