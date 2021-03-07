# frozen_string_literal: true

module Eve
  class FactionRepository
    class << self
      def update(faction_id, input, locale)
        record = FactionRecord.find_or_initialize_by(faction_id: faction_id)
        record.update!(faction_id: input.faction_id,
                       corporation_id: input.corporation_id,
                       "description_#{locale}": input.send(:"description_#{locale}"),
                       is_unique: input.is_unique,
                       militia_corporation_id: input.militia_corporation_id,
                       "name_#{locale}": input.send(:"name_#{locale}"),
                       size_factor: input.size_factor,
                       solar_system_id: input.solar_system_id,
                       station_count: input.station_count,
                       station_system_count: input.station_system_count)
        to_model(record.attributes)
      end

      private

      def to_model(attributes)
        Faction.new(**attributes.symbolize_keys)
      end
    end
  end
end
