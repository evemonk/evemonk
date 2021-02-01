# frozen_string_literal: true

module Eve
  class FactionDecorator < ApplicationDecorator
    decorates_associations :corporation, :militia_corporation, :solar_system,
      :alliances, :standings

    def size_factor
      object.size_factor.to_s
    end
  end
end
