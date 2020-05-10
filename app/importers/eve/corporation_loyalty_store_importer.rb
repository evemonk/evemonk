# frozen_string_literal: true

module Eve
  class CorporationLoyaltyStoreImporter
    attr_reader :corporation_id

    def initialize(corporation_id)
      @corporation_id = corporation_id
    end

    def import
      ActiveRecord::Base.transaction do
        eve_corporation = Eve::Corporation.find_by!(corporation_id: corporation_id)

        esi = EveOnline::ESI::CorporationLoyaltyStoreOffers.new(corporation_id: corporation_id)

        etag = Eve::Etag.find_or_initialize_by(url: esi.url)

        esi.etag = etag.etag

        return if esi.not_modified?

        eve_corporation.loyalty_store_offers.destroy_all

        esi.offers.each do |offer|
          eve_corporation.loyalty_store_offers.create!(offer.as_json)
        end
      end
    end
  end
end
