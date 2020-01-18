# frozen_string_literal: true

module Eve
  class PlanetDecorator < ApplicationDecorator
    decorates_associations :position
  end
end
