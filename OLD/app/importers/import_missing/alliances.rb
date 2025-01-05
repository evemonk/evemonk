# frozen_string_literal: true

module ImportMissing
  class Alliances
    def import
      Rails.logger.info "Import missing eve alliances"

      alliance_ids.each do |alliance_id|
        Eve::UpdateAllianceJob.perform_later(alliance_id)

        Eve::UpdateAllianceLogoJob.perform_later(alliance_id)
      end
    end

    private

    def alliance_ids
      Character.where.not(alliance_id: nil)
        .where.missing(:alliance)
        .pluck(:alliance_id)
        .sort
        .uniq
    end
  end
end
