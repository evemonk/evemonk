# frozen_string_literal: true

module Eve
  class CorporationLoyaltyStoreImporter < BaseImporter
    attr_reader :corporation_id

    def initialize(corporation_id)
      @corporation_id = corporation_id
    end

    def import
      import! do
        eve_corporation = Eve::Corporation.find_by!(corporation_id: corporation_id)

        eve_corporation.loyalty_store_offers.destroy_all

        esi.offers.each do |offer|
          eve_corporation.loyalty_store_offers.create!(offer.as_json)
        end
      rescue ActiveRecord::RecordNotFound
        Rails.logger.info("Corporation with ID #{corporation_id} not found")
      end
    end

    def esi
      @esi ||= EveOnline::ESI::CorporationLoyaltyStoreOffers.new(corporation_id: corporation_id)
    end
  end
end
