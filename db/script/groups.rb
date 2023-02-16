# frozen_string_literal: true

Rails.logger.info "Migrate Eve::Group#group_id to #id"

ActiveRecord::Base.transaction do
  start = 1_000

  Eve::Group.find_each do |group|
    group.update_column(:id, start)
    start += 1
  end

  Eve::Group.find_each do |group|
    group.update_column(:id, group.group_id)
  end
end
