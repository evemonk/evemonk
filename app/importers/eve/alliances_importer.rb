# frozen_string_literal: true

module Eve
  class AlliancesImporter < BaseImporter
    def import
      import! do
        remove_old_alliances

        import_new_alliances
      end
    end

    private

    def client
      @client ||= EveOnline::ESI::Client.new(cache: true, cache_store: Rails.cache)
    end

    def alliances
      @alliances ||= client.alliances.list
    end

    def import_new_alliances
      eve_alliance_ids = Eve::Alliance.ids

      eve_alliance_ids_to_create = alliances.alliance_ids - eve_alliance_ids

      eve_alliance_ids_to_create.each do |alliance_id|
        Eve::UpdateAllianceJob.perform_later(alliance_id)
      end
    end

    def remove_old_alliances
      eve_alliance_ids = Eve::Alliance.ids

      alliance_ids_to_remove = eve_alliance_ids - alliances.alliance_ids

      alliance_ids_to_remove.each do |id|
        eve_alliance = Eve::Alliance.find_or_initialize_by(id: id)

        eve_alliance.corporations.ids.each do |corporation_id|
          Eve::UpdateCorporationJob.perform_later(corporation_id)
        end

        eve_alliance.destroy!
      end
    end
  end
end
