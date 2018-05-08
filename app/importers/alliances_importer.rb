# frozen_string_literal: true

class AlliancesImporter
  def import
    alliances_ids = EveOnline::ESI::Alliances.new.alliances

    alliances_ids.each do |alliance_id|
      alliance = Eve::Alliance.find_or_initialize_by(alliance_id: alliance_id)

      options = { alliance_id: alliance_id }

      begin
        alliance.update!(EveOnline::ESI::Alliance.new(options).as_json)

        alliance.update!(EveOnline::ESI::AllianceIcon.new(options).as_json)
      rescue EveOnline::Exceptions::ResourceNotFound
        Rails.logger.info("Alliance with ID '#{ alliance_id }' not found. Skip.")
      end
    end
  end
end
