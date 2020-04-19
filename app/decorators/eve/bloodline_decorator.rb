# frozen_string_literal: true

module Eve
  class BloodlineDecorator < ApplicationDecorator
    decorates_associations :corporation, :race, :ancestries
  end
end
