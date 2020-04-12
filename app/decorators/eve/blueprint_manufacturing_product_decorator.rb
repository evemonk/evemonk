# frozen_string_literal: true

module Eve
  class BlueprintManufacturingProductDecorator < ApplicationDecorator
    decorates_associations :blueprint, :type
  end
end
