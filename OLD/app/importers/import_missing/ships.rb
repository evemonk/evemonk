# frozen_string_literal: true

module ImportMissing
  class Ships
    def import
      Rails.logger.info "Import missing eve ships"

      ship_ids.each do |type_id|
        Eve::UpdateTypeJob.perform_later(type_id)
      end
    end

    private

    def ship_ids
      Character.where.not(current_ship_type_id: nil)
        .where.missing(:current_ship_type)
        .pluck(:current_ship_type_id)
        .sort
        .uniq
    end
  end
end
