# frozen_string_literal: true

class WelcomeIndexAction < Upgrow::Action
  result :alliances, :corporations

  def perform
    result.success(alliances: Eve::AllianceRepository.new.top20,
                   corporations: Eve::CorporationRepository.new.top20)
  end
end