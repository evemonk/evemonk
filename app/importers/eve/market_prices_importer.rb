# frozen_string_literal: true

module Eve
  class MarketPricesImporter
    attr_reader :esi

    def initialize
      @esi = EveOnline::ESI::MarketPrices.new
    end

    def import
      etag = Eve::Etag.find_or_initialize_by(url: esi.url)

      esi.etag = etag.etag

      return if esi.not_modified?

      update_market_prices

      etag.update!(etag: esi.etag, body: esi.response)
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
