# frozen_string_literal: true

class TopAlliancesComponent < ApplicationComponent
  include Turbo::FramesHelper

  def initialize(alliances:)
    @alliances = alliances
  end
end
