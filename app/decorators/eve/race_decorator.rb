# frozen_string_literal: true

module Eve
  class RaceDecorator < ApplicationDecorator
    # decorates_associations :alliance, :bloodlines, :stations
    decorates_associations :bloodlines, :stations
  end
end
