# frozen_string_literal: true

module Eve
  class AncestriesImporter
    def import
      Mobility.with_locale(:en) do
        ActiveRecord::Base.transaction do
          esi = EveOnline::ESI::UniverseAncestries.new

          etag = Eve::Etag.find_or_initialize_by(url: esi.url)

          esi.etag = etag.etag

          return if esi.not_modified?

          esi.ancestries.each do |ancestry|
            eve_ancestry = Eve::Ancestry.find_or_initialize_by(ancestry_id: ancestry.ancestry_id)

            eve_ancestry.update!(ancestry.as_json)
          end

          etag.update!(etag: esi.etag)
        end
      end
    end
  end
end
