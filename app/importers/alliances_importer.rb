# frozen_string_literal: true

class AlliancesImporter
  def import
    alliances = EveOnline::ESI::Alliances.new

    alliances.alliances.each do |alliance_id|
      alliance = EveOnline::ESI::Alliance.new(alliance_id: alliance_id)

      Eve::Alliance.create!(alliance.as_json)
    end
  end
end
