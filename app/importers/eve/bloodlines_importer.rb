# frozen_string_literal: true

module Eve
  class BloodlinesImporter
    def import
      current_etag = Redis.current.get("bloodlines:#{ I18n.locale }:etag")

      eveonline_esi_bloodlines = EveOnline::ESI::UniverseBloodlines.new(etag: current_etag)

      return if eveonline_esi_bloodlines.not_modified?

      eveonline_esi_bloodlines.bloodlines.each do |bloodline|
        eve_bloodline = Eve::Bloodline.find_or_initialize_by(bloodline_id: bloodline.bloodline_id)

        eve_bloodline.assign_attributes(bloodline.as_json)

        eve_bloodline.save! if eve_bloodline.changed?
      end

      Redis.current.set("bloodlines:#{ I18n.locale }:etag", eveonline_esi_bloodlines.etag)
    end
  end
end
