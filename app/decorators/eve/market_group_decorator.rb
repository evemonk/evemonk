# frozen_string_literal: true

module Eve
  class MarketGroupDecorator < ApplicationDecorator
    decorates_associations :parent_group, :types
  end
end
