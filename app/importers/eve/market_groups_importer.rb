# frozen_string_literal: true

module Eve
  class MarketGroupsImporter < BaseImporter
    def import
      import! do
        import_new_market_groups

        remove_old_market_groups
      end
    end

    def esi
      @esi ||= EveOnline::ESI::MarketGroups.new
    end

    private

    def import_new_market_groups
      esi.market_group_ids.each do |market_group_id|
        unless Eve::MarketGroup.exists?(id: market_group_id)
          Eve::UpdateMarketGroupJob.perform_later(market_group_id)
        end
      end
    end

    def remove_old_market_groups
      eve_market_group_ids = Eve::MarketGroup.pluck(:id)

      eve_market_group_ids_to_remove = eve_market_group_ids - esi.market_group_ids

      eve_market_group_ids_to_remove.each do |market_group_id|
        eve_market_group = Eve::MarketGroup.find_or_initialize_by(id: market_group_id)

        eve_market_group.destroy!
      end
    end
  end
end
