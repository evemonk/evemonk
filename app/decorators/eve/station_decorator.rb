# frozen_string_literal: true

module Eve
  class StationDecorator < ApplicationDecorator
    decorates_associations :race, :type, :position
  end
end
