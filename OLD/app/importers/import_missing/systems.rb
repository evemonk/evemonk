# frozen_string_literal: true

module ImportMissing
  class Systems
    def import
      Rails.logger.info "Import missing eve systems"

      system_ids.each do |system_id|
        Eve::UpdateSystemJob.perform_later(system_id)
      end
    end

    private

    def system_ids
      Character.where.not(current_solar_system_id: nil)
        .where.missing(:current_solar_system)
        .pluck(:current_solar_system_id)
        .sort
        .uniq
    end
  end
end
