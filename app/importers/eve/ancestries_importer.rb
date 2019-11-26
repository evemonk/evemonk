# frozen_string_literal: true

module Eve
  class AncestriesImporter
    attr_reader :locale

    def initialize(locale = :en)
      @locale = locale
    end

    def import
      Mobility.with_locale(locale) do
        ActiveRecord::Base.transaction do
          esi = EveOnline::ESI::UniverseAncestries.new(language: LanguageMapper::LANGUAGES[locale])

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
