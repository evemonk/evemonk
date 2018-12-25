# frozen_string_literal: true

module Eve
  class AncestriesImporter
    def import
      current_etag = Redis.current.get("ancestries:#{ I18n.locale }:etag")

      eveonline_esi_ancestries = EveOnline::ESI::UniverseAncestries.new(etag: current_etag)

      return if eveonline_esi_ancestries.not_modified?

      eveonline_esi_ancestries.ancestries.each do |ancestry|
        eve_ancestry = Eve::Ancestry.find_or_initialize_by(ancestry_id: ancestry.ancestry_id)

        eve_ancestry.assign_attributes(ancestry.as_json)

        eve_ancestry.save! if eve_ancestry.changed?
      end

      Redis.current.set("ancestries:#{ I18n.locale }:etag", eveonline_esi_ancestries.etag)
    end
  end
end
