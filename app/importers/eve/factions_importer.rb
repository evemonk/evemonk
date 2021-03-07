# frozen_string_literal: true

module Eve
  class FactionsImporter < BaseImporter
    attr_reader :locale

    def initialize(locale = :en)
      @locale = locale
    end

    def import
      import! do
        return if esi.not_modified?

        esi.factions.each do |faction|
          input = FactionInput.new(faction_id: faction.faction_id,
                                   corporation_id: faction.corporation_id,
                                   "description_#{locale}": faction.description,
                                   is_unique: faction.is_unique,
                                   militia_corporation_id: faction.militia_corporation_id,
                                   "name_#{locale}": faction.name,
                                   size_factor: faction.size_factor,
                                   solar_system_id: faction.solar_system_id,
                                   station_count: faction.station_count,
                                   station_system_count: faction.station_system_count)

          FactionRepository.update(faction.faction_id, input, locale)
        end

        update_etag
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseFactions.new(language: LanguageMapper::LANGUAGES[locale])
    end
  end
end
