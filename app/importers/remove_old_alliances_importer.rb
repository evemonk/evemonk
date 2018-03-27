class RemoveOldAlliances
  def remove
    alliances_ids = EveOnline::ESI::Alliances.new.alliances

    removed_alliance_ids = Eve::Alliance.pluck(:alliance_id) - alliances_ids

    removed_alliance_ids.each do |alliance_id|
      Eve::Alliance.find_by(alliance_id: alliance_id).destroy
    end
  end
end
