# frozen_string_literal: true

module Eve
  class AllianceImporter < BaseImporter
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def import
      import! do
        eve_alliance = Eve::Alliance.find_or_initialize_by(id: id)

        return if esi.not_modified?

        eve_alliance.update!(esi.as_json)

        update_etag
      rescue EveOnline::Exceptions::ResourceNotFound
        Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Alliance ID #{id}")

        etag.destroy!

        eve_alliance.destroy!
      end
    end

    def esi
      @esi ||= EveOnline::ESI::Alliance.new(alliance_id: id)
    end
  end
end
