# frozen_string_literal: true

class AlliancesImporter
  def import
    alliances_ids = EveOnline::ESI::Alliances.new.alliances

    alliances_ids.each do |alliance_id|
      alliance = Eve::Alliance.find_or_initialize_by(alliance_id: alliance_id)

      options = { alliance_id: alliance_id }

      alliance.update!(EveOnline::ESI::Alliance.new(options).as_json)

      alliance.update!(EveOnline::ESI::AllianceIcon.new(options).as_json)
    end
  end
end
