# frozen_string_literal: true

module Eve
  class TypeDogmaAttributeDecorator < ApplicationDecorator
    decorates_associations :type, :dogma_attribute
  end
end
