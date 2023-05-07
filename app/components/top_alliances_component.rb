# frozen_string_literal: true

class TopAlliancesComponent < ApplicationComponent
  def initialize(alliances:)
    @alliances = alliances
  end
end
