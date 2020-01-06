# frozen_string_literal: true

module Eve
  class ConstellationDecorator < ApplicationDecorator
    decorates_associations :position
  end
end
