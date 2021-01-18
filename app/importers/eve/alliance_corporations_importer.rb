# frozen_string_literal: true

module Eve
  class AllianceCorporationsImporter < BaseImporter
    attr_reader :alliance_id

    def initialize(alliance_id)
      @alliance_id = alliance_id
    end

    def import
      import! do
        return if esi.not_modified?

        import_new_corporations

        remove_old_corporations

        update_etag
      rescue ActiveRecord::RecordNotFound
        Rails.logger.info("Alliance with ID #{alliance_id} not found")
      rescue EveOnline::Exceptions::ResourceNotFound
        etag.destroy!

        eve_alliance.destroy!
      end
    end

    def esi
      @esi ||= EveOnline::ESI::AllianceCorporations.new(alliance_id: alliance_id)
    end

    private

    def import_new_corporations
      corporation_ids = esi.corporation_ids - eve_alliance.corporations.pluck(:corporation_id)

      corporation_ids.each do |corporation_id|
        Eve::UpdateCorporationJob.perform_later(corporation_id)
      end
    end

    def remove_old_corporations
      corporation_ids = eve_alliance.corporations.pluck(:corporation_id) - esi.corporation_ids

      corporation_ids.each do |corporation_id|
        Eve::UpdateCorporationJob.perform_later(corporation_id)
      end
    end

    def eve_alliance
      @eve_alliance ||= Eve::Alliance.find_by!(alliance_id: alliance_id)
    end
  end
end
