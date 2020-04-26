# frozen_string_literal: true

module Eve
  class PlanetDecorator < ApplicationDecorator
    decorates_associations :system, :type, :moons, :asteroid_belts, :position
  end
end
