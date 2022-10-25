# frozen_string_literal: true

module Eve
  class AllianceCorporationsImporter < BaseImporter
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def import
      import! do
        return if esi.not_modified?

        import_new_corporations

        remove_old_corporations

        update_etag
      rescue ActiveRecord::RecordNotFound
        Rails.logger.info("Alliance with ID #{id} not found")
      rescue EveOnline::Exceptions::ResourceNotFound
        etag.destroy!

        eve_alliance.destroy!
      end
    end

    def esi
      @esi ||= EveOnline::ESI::AllianceCorporations.new(alliance_id: id)
    end

    private

    def import_new_corporations
      corporation_ids = esi.corporation_ids - eve_alliance.corporations.pluck(:corporation_id)

      corporation_ids.each do |id|
        Eve::UpdateCorporationJob.perform_later(id)
      end
    end

    def remove_old_corporations
      corporation_ids = eve_alliance.corporations.pluck(:corporation_id) - esi.corporation_ids

      corporation_ids.each do |id|
        Eve::UpdateCorporationJob.perform_later(id)
      end
    end

    def eve_alliance
      @eve_alliance ||= Eve::Alliance.find(id)
    end
  end
end
