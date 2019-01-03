# frozen_string_literal: true

module Eve
  class BloodlinesImporter
    def import
      eveonline_esi_bloodlines = EveOnline::ESI::UniverseBloodlines.new

      etag = Etag.find_or_initialize_by(url: eveonline_esi_bloodlines.url)

      eveonline_esi_bloodlines.etag = etag.etag

      return if eveonline_esi_bloodlines.not_modified?

      eveonline_esi_bloodlines.bloodlines.each do |bloodline|
        eve_bloodline = Eve::Bloodline.find_or_initialize_by(bloodline_id: bloodline.bloodline_id)

        eve_bloodline.update!(bloodline.as_json)
      end

      etag.update!(etag: eveonline_esi_bloodlines.etag)
    end
  end
end
