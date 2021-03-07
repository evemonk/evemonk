# frozen_string_literal: true

module Eve
  class AllianceRepository
    class << self
      def update(alliance_id, input)
        record = AllianceRecord.find_or_initialize_by(alliance_id: alliance_id)
        record.update!(alliance_id: input.alliance_id,
                       creator_corporation_id: input.creator_corporation_id,
                       creator_id: input.creator_id,
                       date_founded: input.date_founded,
                       executor_corporation_id: input.executor_corporation_id,
                       faction_id: input.faction_id,
                       name: input.name,
                       ticker: input.ticker,
                       corporations_count: input.corporations_count,
                       characters_count: input.characters_count)
        to_model(record.attributes)
      end

      def destroy(alliance_id)
        record = AllianceRecord.find_or_initialize_by(alliance_id: alliance_id)
        record.destroy!
      end

      def top20
        AllianceRecord.order(characters_count: :desc).limit(20).map do |record|
          to_model(record.attributes)
        end
      end

      def alliance_ids
        AllianceRecord.pluck(:alliance_id).sort
      end

      def find_by_alliance_id(alliance_id)
        record = AllianceRecord.find_by!(alliance_id: alliance_id)
        to_model(record.attributes)
      end

      def corporation_ids(alliance_id)
        AllianceRecord.find_by!(alliance_id: alliance_id).corporation_records.pluck(:corporation_id)
      end

      private

      def to_model(attributes)
        Alliance.new(**attributes.symbolize_keys)
      end
    end
  end
end
