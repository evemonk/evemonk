# frozen_string_literal: true

class TopAlliancesComponent < ViewComponent::Base
  def initialize(alliances:)
    @alliances = alliances
  end
end
