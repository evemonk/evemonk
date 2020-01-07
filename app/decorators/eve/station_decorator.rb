# frozen_string_literal: true

module Eve
  class StationDecorator < ApplicationDecorator
    decorates_associations :position
  end
end
