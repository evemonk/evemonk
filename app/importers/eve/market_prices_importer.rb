# frozen_string_literal: true

module Eve
  class MarketPricesImporter < BaseImporter
    def import
      import! do
        return if esi.not_modified?

        update_market_prices

        update_etag
      end
    end

    def esi
      @esi ||= EveOnline::ESI::MarketPrices.new
    end

    private

    def update_market_prices
      esi.market_prices.each do |market_price|
        eve_type = Eve::Type.find_or_initialize_by(type_id: market_price.type_id)

        eve_type.update!(market_price.as_json)
      end
    end
  end
end
