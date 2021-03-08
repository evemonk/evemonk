# frozen_string_literal: true

module Eve
  class RaceRepository
    class << self
      def update(race_id, input, locale)
        record = RaceRecord.find_or_initialize_by(race_id: race_id)
        record.update!(race_id: input.race_id,
                       faction_id: input.faction_id,
                       "description_#{locale}": input.send(:"description_#{locale}"),
                       "name_#{locale}": input.send(:"name_#{locale}"))
        to_model(record.attributes)
      end

      private

      def to_model(attributes)
        Race.new(**attributes.symbolize_keys)
      end
    end
  end
end
