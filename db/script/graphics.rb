# frozen_string_literal: true

Rails.logger.info "Migrate Eve::Graphic#graphic_id to #id"

ActiveRecord::Base.transaction do
  Eve::Graphic.find_each do |graphic|
    graphic.update_column(:id, graphic.graphic_id)
  end
end

Rails.logger.info "Done"
