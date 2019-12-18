# frozen_string_literal: true

module Eve
  class MarketGroupsImporter
    attr_reader :esi

    def initialize
      @esi = EveOnline::ESI::MarketGroups.new
    end

    def import
      ActiveRecord::Base.transaction do
        etag = Eve::Etag.find_or_initialize_by(url: esi.url)

        esi.etag = etag.etag

        return if esi.not_modified?

        import_new_market_groups

        remove_old_market_groups

        etag.update!(etag: esi.etag, body: esi.response)
      end
    end

    private

    def import_new_market_groups
      esi.market_group_ids.each do |market_group_id|
        unless Eve::MarketGroup.exists?(market_group_id: market_group_id)
          Eve::UpdateMarketGroupJob.perform_later(market_group_id)
        end
      end
    end

    def remove_old_market_groups
      #eve_alliance_ids = Eve::Alliance.pluck(:alliance_id)
      #
      #alliance_ids_to_remove = eve_alliance_ids - esi.alliance_ids
      #
      #alliance_ids_to_remove.each do |alliance_id|
      #  eve_alliance = Eve::Alliance.find_or_initialize_by(alliance_id: alliance_id)
      #
      #  eve_alliance.corporations.each do |corporation|
      #    Eve::CorporationImporterWorker.perform_async(corporation.corporation_id)
      #  end
      #
      #  eve_alliance.destroy!
      #end
      #
    end
  end
end
