# frozen_string_literal: true

class WelcomeIndexAction < Upgrow::Action
  result :alliances, :corporations

  def perform
    result.success(alliances: Eve::AllianceRepository.top20,
                   corporations: Eve::CorporationRepository.top20)
  end
end
