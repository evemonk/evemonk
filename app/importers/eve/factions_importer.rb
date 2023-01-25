# frozen_string_literal: true

module Eve
  class FactionsImporter < BaseImporter
    attr_reader :locale

    def initialize(locale = :en)
      @locale = locale
    end

    def import
      import! do
        Mobility.with_locale(locale) do
          esi.factions.each do |faction|
            eve_faction = Eve::Faction.find_or_initialize_by(faction_id: faction.faction_id)

            eve_faction.update!(faction.as_json)
          end
        end
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseFactions.new(language: LanguageMapper::LANGUAGES[locale])
    end
  end
end
