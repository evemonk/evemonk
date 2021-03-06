# frozen_string_literal: true

module Eve
  class CorporationRepository
    def top20
      CorporationRecord.where(npc: false).order(member_count: :desc).limit(20).map do |record|
        to_model(record.attributes)
      end
    end

    private

    def to_model(attributes)
      Corporation.new(**attributes.symbolize_keys)
    end
  end
end
