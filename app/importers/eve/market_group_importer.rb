# frozen_string_literal: true

module Eve
  class MarketGroupImporter < BaseImporter
    attr_reader :market_group_id, :locale

    def initialize(market_group_id, locale = :en)
      @market_group_id = market_group_id
      @locale = locale
    end

    def import!
      Mobility.with_locale(locale) do
        eve_market_group = Eve::MarketGroup.find_or_initialize_by(market_group_id: market_group_id)

        eve_market_group.update!(esi.as_json)
      rescue EveOnline::Exceptions::ResourceNotFound
        eve_market_group.destroy!
      end
    end

    def esi
      @esi ||= EveOnline::ESI::MarketGroup.new(id: market_group_id, language: LanguageMapper::LANGUAGES[locale])
    end
  end
end
