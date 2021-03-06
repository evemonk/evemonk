# frozen_string_literal: true

module Eve
  class AllianceRepository
    def update(alliance_id, attributes)
      record = AllianceRecord.find_or_initialize_by(alliance_id: alliance_id)
      record.update!(attributes)
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
      AllianceRecord.pluck(:alliance_id)
    end

    private

    def to_model(attributes)
      Alliance.new(**attributes.symbolize_keys)
    end
  end
end
