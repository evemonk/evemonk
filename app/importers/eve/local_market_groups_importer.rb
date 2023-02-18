# frozen_string_literal: true

module Eve
  class LocalMarketGroupsImporter
    def import
      Eve::MarketGroup.pluck(:id).each do |market_group_id|
        Eve::UpdateMarketGroupJob.perform_later(market_group_id)
      end
    end
  end
end
