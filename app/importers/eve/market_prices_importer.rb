# frozen_string_literal: true

module Eve
  class MarketPricesImporter < BaseImporter
    def import
      import! do
        update_market_prices
      end
    end

    def esi
      @esi ||= EveOnline::ESI::MarketPrices.new
    end

    private

    def update_market_prices
      esi.market_prices.each do |market_price|
        eve_type = Eve::Type.find_or_initialize_by(id: market_price.id)

        eve_type.update!(market_price.as_json)
      end
    end
  end
end
