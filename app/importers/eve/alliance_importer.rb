# frozen_string_literal: true

module Eve
  class AllianceImporter < BaseImporter
    attr_reader :alliance_id

    def initialize(alliance_id)
      @alliance_id = alliance_id
    end

    def import
      import! do
        return if esi.not_modified?

        input = AllianceInput.new(alliance_id: esi.alliance_id,
                                  creator_corporation_id: esi.creator_corporation_id,
                                  creator_id: esi.creator_id,
                                  date_founded: esi.date_founded,
                                  executor_corporation_id: esi.executor_corporation_id,
                                  faction_id: esi.faction_id,
                                  name: esi.name,
                                  ticker: esi.ticker)

        AllianceRepository.update(alliance_id, input)

        update_etag
      rescue EveOnline::Exceptions::ResourceNotFound
        Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Alliance ID #{alliance_id}")

        EtagRepository.destroy(esi.url)
        AllianceRepository.destroy(alliance_id)
      end
    end

    def esi
      @esi ||= EveOnline::ESI::Alliance.new(alliance_id: alliance_id)
    end
  end
end
