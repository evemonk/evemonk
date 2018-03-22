# frozen_string_literal: true

class AlliancesImporter
  def import
    alliances = EveOnline::ESI::Alliances.new

    alliances.alliances.each do |alliance_id|
      options = { alliance_id: alliance_id }

      alliance = EveOnline::ESI::Alliance.new(options)

      alliance_icon = EveOnline::ESI::AllianceIcon.new(options)

      json = alliance.as_json.merge(alliance_icon.as_json)
                             .merge(alliance_id: alliance_id)

      Eve::Alliance.create!(json)
    end
  end
end
