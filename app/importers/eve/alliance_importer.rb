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

        eve_alliance.update!(esi.as_json)

        eve_alliance.reset_corporations_count

        eve_alliance.reset_characters_count
      rescue EveOnline::Exceptions::ResourceNotFound
        Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Alliance ID #{id}")

        eve_alliance.destroy!
      end
    end

    def esi
      @esi ||= EveOnline::ESI::Alliance.new(alliance_id: id)
    end
  end
end
