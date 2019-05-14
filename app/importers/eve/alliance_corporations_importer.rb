# frozen_string_literal: true

module Eve
  class AllianceCorporationsImporter
    attr_reader :alliance_id

    def initialize(alliance_id)
      @alliance_id = alliance_id
    end

    def import
      # TODO: etag support
      eve_alliance = Eve::Alliance.find_by!(alliance_id: alliance_id)

      esi = EveOnline::ESI::AllianceCorporations.new(alliance_id: alliance_id)

      remote_corporation_ids = esi.corporation_ids

      local_corporation_ids = eve_alliance.alliance_corporations.pluck(:corporation_id)

      ids_to_create = remote_corporation_ids - local_corporation_ids

      ids_to_remove = local_corporation_ids - remote_corporation_ids

      ids_to_create.each do |corporation_id|
        eve_alliance.alliance_corporations.create!(corporation_id: corporation_id)
      end

      ids_to_remove.each do |corporation_id|
        eve_alliance.alliance_corporations.where(corporation_id: corporation_id).destroy_all
      end
    rescue ActiveRecord::RecordNotFound
      Rails.logger.info("Alliance with ID #{ alliance_id } not found")
    end
  end
end
