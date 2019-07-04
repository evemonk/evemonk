# frozen_string_literal: true

module Eve
  class BloodlinesImporter
    def import
      esi = EveOnline::ESI::UniverseBloodlines.new

      etag = Eve::Etag.find_or_initialize_by(url: esi.url)

      esi.etag = etag.etag

      return if esi.not_modified?

      esi.bloodlines.each do |bloodline|
        eve_bloodline = Eve::Bloodline.find_or_initialize_by(bloodline_id: bloodline.bloodline_id)

        eve_bloodline.update!(bloodline.as_json)
      end

      etag.update!(etag: esi.etag)
    end
  end
end
