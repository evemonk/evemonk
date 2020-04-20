# frozen_string_literal: true

module Eve
  class ConstellationDecorator < ApplicationDecorator
    decorates_associations :region, :systems, :position
  end
end
