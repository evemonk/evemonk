# frozen_string_literal: true

module Eve
  class BloodlineDecorator < ApplicationDecorator
    decorates_associations :corporation, :race, :ship_type, :ancestries
  end
end
