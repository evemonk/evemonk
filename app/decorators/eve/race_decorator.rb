# frozen_string_literal: true

module Eve
  class RaceDecorator < ApplicationDecorator
    decorates_associations :alliance, :bloodlines
  end
end
