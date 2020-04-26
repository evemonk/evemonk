# frozen_string_literal: true

module Eve
  class AsteroidBeltDecorator < ApplicationDecorator
    decorates_associations :system, :planet, :position
  end
end
