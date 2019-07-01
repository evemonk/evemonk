# frozen_string_literal: true

module Eve
  class FactionDecorator < ApplicationDecorator
    decorates_associations :alliances, :corporation
  end
end
