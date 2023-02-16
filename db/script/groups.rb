# frozen_string_literal: true

Rails.logger.info "Migrate Eve::Group#group_id to #id"

ActiveRecord::Base.transaction do
  start = 1_000
end
