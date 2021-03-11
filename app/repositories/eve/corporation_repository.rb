# frozen_string_literal: true

module Eve
  class CorporationRepository
    class << self
      def update(corporation_id, input)
        record = CorporationRecord.find_or_initialize_by(corporation_id: corporation_id)
        record.update!(corporation_id: input.corporation_id,
                       alliance_id: input.alliance_id,
                       ceo_id: input.ceo_id,
                       creator_id: input.creator_id,
                       date_founded: input.date_founded,
                       description: input.description,
                       faction_id: input.faction_id,
                       home_station_id: input.home_station_id,
                       member_count: input.member_count,
                       name: input.name,
                       shares: input.shares,
                       tax_rate: input.tax_rate,
                       ticker: input.ticker,
                       corporation_url: input.corporation_url,
                       war_eligible: input.war_eligible,
                       npc: input.npc)
        to_model(record.attributes)
      end

      def destroy(corporation_id)
        record = CorporationRecord.find_or_initialize_by(corporation_id: corporation_id)
        record.destroy!
      end

      def top20
        CorporationRecord.where(npc: false).order(member_count: :desc).limit(20).map do |record|
          to_model(record.attributes)
        end
      end

      def corporation_ids
        Eve::CorporationRecord.pluck(:corporation_id).sort
      end

      def with_faction_for_alliance(alliance_id)
        CorporationRecord.where(alliance_id: alliance_id).order(:name).includes(:faction).map do |record|
          to_model(record.attributes)
        end


        # @corporations = ::Eve::Corporation
        #   .where(alliance: @alliance)
        #   .order(:name)
        #   .includes(:faction)
      end

      private

      def to_model(attributes)
        Corporation.new(**attributes.symbolize_keys)
      end
    end
  end
end
