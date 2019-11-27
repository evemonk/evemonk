# frozen_string_literal: true

module Eve
  class FactionsImporter
    attr_reader :locale

    def initialize(locale = :en)
      @locale = locale
    end

    def import
      Mobility.with_locale(locale) do
        ActiveRecord::Base.transaction do
          esi = EveOnline::ESI::UniverseFactions.new(language: LanguageMapper::LANGUAGES[locale])

          etag = Eve::Etag.find_or_initialize_by(url: esi.url)

          esi.etag = etag.etag

          return if esi.not_modified?

          esi.factions.each do |faction|
            eve_faction = Eve::Faction.find_or_initialize_by(faction_id: faction.faction_id)

            eve_faction.update!(faction.as_json)
          end

          etag.update!(etag: esi.etag, body: esi.response)
        end
      end
    end
  end
end
