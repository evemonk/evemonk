# frozen_string_literal: true

class IndustryJobDecorator < ApplicationDecorator
  decorates_associations :character, :product_type, :blueprint_type
end
