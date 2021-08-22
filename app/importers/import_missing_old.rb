# frozen_string_literal: true

class ImportMissingOld
  def import
    Rails.logger.info "Import eve ships"
    Character.where.not(current_ship_type_id: nil)
      .pluck(:current_ship_type_id)
      .sort
      .uniq
      .each do |type_id|
      Eve::UpdateTypeJob.perform_later(type_id)
    end
  end
end
