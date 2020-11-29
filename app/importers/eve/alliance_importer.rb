# frozen_string_literal: true

module Eve
  class AllianceImporter < BaseImporter
    attr_reader :alliance_id

    def initialize(alliance_id)
      @alliance_id = alliance_id
    end

    def import
      import! do
        eve_alliance = Eve::Alliance.find_or_initialize_by(alliance_id: alliance_id)

        return if esi.not_modified?

        eve_alliance.update!(esi.as_json)

        update_etag
      rescue EveOnline::Exceptions::ResourceNotFound
        Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Alliance ID #{alliance_id}")

        etag.destroy!

        eve_alliance.destroy!
      end
    end

    def esi
      @esi ||= EveOnline::ESI::Alliance.new(alliance_id: alliance_id)
    end
  end
end
