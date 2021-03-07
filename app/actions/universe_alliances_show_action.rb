class UniverseAlliancesShowAction < Upgrow::Action
  result :alliance, :corporations

  def perform(alliance_id)
    alliance = Eve::AllianceRepository.find_with_more_info(alliance_id)
    corporations = Eve::CorporationRepository.with_faction_for_alliance(alliance_id)

    result.success(alliance: alliance,
                   corporations: corporations)
  end
end