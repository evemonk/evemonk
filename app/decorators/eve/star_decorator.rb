# frozen_string_literal: true

module Eve
  class StarDecorator < ApplicationDecorator
    decorates_associations :solar_system, :type
  end
end
