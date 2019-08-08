# frozen_string_literal: true

module Eve
  class TypeDecorator < ApplicationDecorator
    decorates_associations :type_dogma_attributes, :type_dogma_effects
  end
end
