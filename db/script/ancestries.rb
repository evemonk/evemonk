# frozen_string_literal: true

Rails.logger.info "Migrate Eve::Ancestry#ancestry_id to #id"

ActiveRecord::Base.transaction do
  start = 100

  Eve::Ancestry.find_each do |ancestry|
    ancestry.update_column(:id, start)
    start += 1
  end

  Eve::Ancestry.find_each do |ancestry|
    ancestry.update_column(:id, ancestry.ancestry_id)
  end
end
