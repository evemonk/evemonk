# frozen_string_literal: true

module Eve
  class StationDecorator < ApplicationDecorator
    decorates_associations :race, :type, :system, :position
  end
end
