# frozen_string_literal: true

module Eve
  class SystemDecorator < ApplicationDecorator
    decorates_associations :constellation, :star, :stargates, :planets,
      :moons, :stations, :asteroid_belts, :position

    def security_status
      object.security_status.round(1)
    end
  end
end
