# frozen_string_literal: true

module ImportMissing
  class Corporations
    def import
      Rails.logger.info "Import missing eve corporations"

      corporation_ids.each do |corporation_id|
        Eve::UpdateCorporationJob.perform_later(corporation_id)

        Eve::UpdateCorporationLogoJob.perform_later(corporation_id)
      end
    end

    private

    def corporation_ids
      Character.where.not(corporation_id: nil)
        .where.missing(:corporation)
        .pluck(:corporation_id)
        .sort
        .uniq
    end
  end
end
