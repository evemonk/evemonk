# frozen_string_literal: true

module Eve
  class FactionDecorator < ApplicationDecorator
    decorates_associations :alliances, :corporation

    def size_factor
      object.size_factor.to_s
    end
  end
end
