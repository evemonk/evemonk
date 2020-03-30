# frozen_string_literal: true

module Eve
  class BlueprintManufacturingSkillDecorator < ApplicationDecorator
    decorates_associations :blueprint, :type
  end
end
