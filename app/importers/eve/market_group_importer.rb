# frozen_string_literal: true

module Eve
  class MarketGroupImporter
    attr_reader :market_group_id, :locale

    def initialize(market_group_id, locale = :en)
      @market_group_id = market_group_id
      @locale = locale
    end

    def import
      Mobility.with_locale(locale) do
        ActiveRecord::Base.transaction do
          eve_market_group = Eve::MarketGroup.find_or_initialize_by(market_group_id: market_group_id)

          esi = EveOnline::ESI::MarketGroup.new(id: market_group_id, language: LanguageMapper::LANGUAGES[locale])

          etag = Eve::Etag.find_or_initialize_by(url: esi.url)

          esi.etag = etag.etag

          return if esi.not_modified?

          eve_market_group.update!(esi.as_json)

          etag.update!(etag: esi.etag, body: esi.response)
        rescue EveOnline::Exceptions::ResourceNotFound
          eve_market_group.destroy!
        end
      end
    end
  end
end
