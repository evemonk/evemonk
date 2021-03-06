# frozen_string_literal: true

module Eve
  class AllianceRepository
    def top20
      AllianceRecord.order(characters_count: :desc).limit(20).map do |record|
        to_model(record.attributes)
      end
    end

    private

    def to_model(attributes)
      Alliance.new(**attributes.symbolize_keys)
    end
  end
end
