# frozen_string_literal: true

class TopAlliancesComponent < ApplicationComponent
  include Turbo::FramesHelper

  def initialize(alliances: Eve::Alliance.none)
    @alliances = alliances
  end
end
