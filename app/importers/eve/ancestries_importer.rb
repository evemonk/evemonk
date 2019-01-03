# frozen_string_literal: true

module Eve
  class AncestriesImporter
    def import
      eveonline_esi_ancestries = EveOnline::ESI::UniverseAncestries.new

      etag = Etag.find_or_initialize_by(url: eveonline_esi_ancestries.url)

      eveonline_esi_ancestries.etag = etag.etag

      return if eveonline_esi_ancestries.not_modified?

      eveonline_esi_ancestries.ancestries.each do |ancestry|
        eve_ancestry = Eve::Ancestry.find_or_initialize_by(ancestry_id: ancestry.ancestry_id)

        eve_ancestry.update!(ancestry.as_json)
      end

      etag.update!(etag: eveonline_esi_ancestries.etag)
    end
  end
end
